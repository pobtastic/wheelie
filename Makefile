BUILDDIR = build

OPTIONS  = -d build/html -t

OPTIONS += $(foreach theme,$(THEMES),-T $(theme))
OPTIONS += $(HTML_OPTS)

.PHONY: usage clean wheelie
usage:
	@echo "Targets:"
	@echo "  usage      show this help"
	@echo "  wheelie    build the Wheelie disassembly"
	@echo ""
	@echo "Variables:"
	@echo "  THEMES     CSS theme(s) to use"
	@echo "  HTML_OPTS  options passed to skool2html.py"

.PHONY: clean
clean:
	-rm -rf $(BUILDDIR)/*

.PHONY: wheelie
wheelie:
	if [ ! -f Wheelie.z80 ]; then tap2sna.py @wheelie.t2s; fi
	sna2skool.py -H -c sources/wheelie.ctl Wheelie.z80 > sources/wheelie.skool
	skool2html.py $(OPTIONS) -D -c Config/GameDir=wheelie/dec -c Config/InitModule=sources:bases sources/wheelie.skool sources/wheelie.ref
	skool2html.py $(OPTIONS) -H -c Config/GameDir=wheelie/hex -c Config/InitModule=sources:bases sources/wheelie.skool sources/wheelie.ref

all : wheelie
.PHONY : all
