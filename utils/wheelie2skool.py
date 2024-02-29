#!/usr/bin/env python3
import sys
import os
import argparse
from collections import OrderedDict
from disassemble import Disassemble

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

    def get_disassembly(self):
        pc = 0x6A27
        end = 0x6AA5
        lines = Disassemble(get_snapshot(WHEELIE_Z80), pc, end)
        return lines.run()

    def get_graphics(self):
        lines = []

        addr = 0xC500
        start = 0xC500
        end = 0xE53A
        count = 0x00
        graphic = 0x01
        lines.append(f"b ${addr:04X} Data: Graphics")
        lines.append(f"@ ${addr:04X} label=Graphics_Data")
        while addr <= end:
            byte = self.snapshot[addr]
            if byte == 0xFF:
                lines = self.fill_in_data(lines, start, graphic, count)
                lines.append(f"  ${addr:04X},$01 Terminator.")
                addr += 0x01
                graphic += 0x01
                start = addr
                count = 0x00
            addr += 0x01
            count += 0x01
        count = end-start

        return '\n'.join(lines)

    def fill_in_data(self, lines, start, graphic, count):
        lines.append(f"N ${start:04X} Graphic #N${graphic:02X}.")
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
