COMPILER=cl65
EMU=x16emu

make:
	$(COMPILER) -o BUILD.PRG -t cx16 src/main.asm

run:
	$(EMU) -prg BUILD.PRG -run -debug
