#!/usr/bin/env python3
import sys
import os
import argparse
from collections import OrderedDict

try:
    from skoolkit.snapshot import get_snapshot
    from skoolkit import tap2sna, sna2skool
except ImportError:
    SKOOLKIT_HOME = os.environ.get('SKOOLKIT_HOME')
    if not SKOOLKIT_HOME:
        sys.stderr.write('SKOOLKIT_HOME is not set; aborting\n')
        sys.exit(1)
    if not os.path.isdir(SKOOLKIT_HOME):
        sys.stderr.write('SKOOLKIT_HOME={}; directory not found\n'.format(SKOOLKIT_HOME))
        sys.exit(1)
    sys.path.insert(0, SKOOLKIT_HOME)
    from skoolkit.snapshot import get_snapshot
    from skoolkit import tap2sna, sna2skool

WHEELIE_HOME = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
BUILD_DIR = '{}/sources'.format(WHEELIE_HOME)
WHEELIE_Z80 = '{}/Wheelie.z80'.format(WHEELIE_HOME)


class Wheelie:
    def __init__(self, snapshot):
        self.snapshot = snapshot

    def address(self, addr):
        return self.snapshot[addr] + self.snapshot[addr + 0x01] * 0x100

    def get_graphics(self):
        lines = []

        addr = 0xC500
        end = 0xE53A
        sprite_id = 0x01

        lines.append(f"b ${addr:04X} Sprite Animation Data")
        lines.append(f"@ ${addr:04X} label=SpriteAnimationData")

        while addr <= end:
            sprite_start = addr
            frame_num = 1

            # Process all frames in this sprite sequence
            while addr <= end:
                frame_start = addr

                # Scan forward to find the next terminator (FF or 80)
                while addr <= end and self.snapshot[addr] != 0xFF and self.snapshot[addr] != 0x80:
                    addr += 1

                if addr > end:
                    break

                # Found a terminator
                terminator = self.snapshot[addr]
                frame_length = addr - frame_start

                # Process the frame data
                if frame_length > 0:
                    lines = self.fill_in_frame_data(lines, frame_start, sprite_id, frame_num, frame_length)

                if terminator == 0xFF:
                    # Frame terminator
                    lines.append(f"  ${addr:04X},$01 Frame #N${frame_num:02X} terminator.")
                    addr += 1
                    frame_num += 1

                    # Check if next byte is sequence terminator
                    if addr <= end and self.snapshot[addr] == 0x80:
                        lines.append(f"  ${addr:04X},$01 Animation sequence terminator.")
                        addr += 1
                        break  # End of this sprite sequence

                elif terminator == 0x80:
                    # Sequence terminator (without FF before it)
                    lines.append(f"  ${addr:04X},$01 Animation sequence terminator.")
                    addr += 1
                    break  # End of this sprite sequence

            sprite_id += 1

        return '\n'.join(lines)

    def fill_in_frame_data(self, lines, start, sprite_id, frame_num, data_length):
        if data_length == 0:
            return lines

        if data_length == 10:  # Standard frame: 2 offsets + 8 pixel bytes
            lines.append(f"N ${start:04X} Sprite #N${sprite_id:02X}, Frame #N${frame_num:02X}.")
            lines.append(f"  ${start:04X},$02 X/ Y position offsets.")
            lines.append(f"  ${start + 2:04X},$08 Pixel data (2 character rows × 4 bytes each).")
        elif data_length == 2:  # Just position offsets
            lines.append(f"N ${start:04X} Sprite #N${sprite_id:02X}, Frame #N${frame_num:02X} (position only).")
            lines.append(f"  ${start:04X},$02 X/ Y position offsets.")
        elif data_length == 1:  # Single control byte
            lines.append(f"N ${start:04X} Sprite #N${sprite_id:02X}, Frame #N${frame_num:02X} (control byte).")
            lines.append(f"  ${start:04X},$01 Control data.")
        else:  # Non-standard frame
            lines.append(f"N ${start:04X} Sprite #N${sprite_id:02X}, Frame #N${frame_num:02X} (${data_length:02X} bytes).")
            if data_length >= 2:
                lines.append(f"  ${start:04X},$02 X/ Y position offsets.")
                if data_length > 2:
                    lines.append(f"  ${start+0x02:04X},${data_length-0x02:02X} Pixel/ control data.")
            else:
                lines.append(f"  ${start:04X},${data_length:02X} Frame data.")

        return lines


def run(subcommand):
    if not os.path.isdir(BUILD_DIR):
        os.mkdir(BUILD_DIR)
    if not os.path.isfile(WHEELIE_Z80):
        tap2sna.main(('-d', BUILD_DIR, '@{}/wheelie.t2s'.format(WHEELIE_HOME)))
    wheelie = Wheelie(get_snapshot(WHEELIE_Z80))
    ctlfile = '{}/{}.ctl'.format(BUILD_DIR, subcommand)
    with open(ctlfile, 'wt') as f:
        f.write(getattr(wheelie, methods[subcommand][0])())


###############################################################################
# Begin
###############################################################################
methods = OrderedDict((
    ('disassemble', ('get_disassembly', 'Disassemble')),
    ('graphics', ('get_graphics', 'Graphics (50432-58682)'))
))
subcommands = '\n'.join('  {} - {}'.format(k, v[1]) for k, v in methods.items())
parser = argparse.ArgumentParser(
    usage='%(prog)s SUBCOMMAND',
    description="Produce a skool file snippet for \"Wheelie\". SUBCOMMAND must be one of:\n\n{}".format(
        subcommands),
    formatter_class=argparse.RawTextHelpFormatter,
    add_help=False
)
parser.add_argument('subcommand', help=argparse.SUPPRESS, nargs='?')
namespace, unknown_args = parser.parse_known_args()
if unknown_args or namespace.subcommand not in methods:
    parser.exit(2, parser.format_help())
run(namespace.subcommand)
