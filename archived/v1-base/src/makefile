# Call this makefile by `make -f src/makefile CFLAGS=... OBJS=...`
# in the root working directory.

CROSS_COMPILE = riscv-none-elf-

BIN = is_palindrome.elf

all: clean make-build-dir $(BIN) run

make-build-dir:
	@mkdir -p build

$(BIN): $(OBJS)
	@$(CROSS_COMPILE)gcc -o build/$@ $(addprefix build/, $?)

%.o: src/%.s
	@$(CROSS_COMPILE)gcc $(CFLAGS) -c -o build/$@ $?

%.o: src/%.c
	@$(CROSS_COMPILE)gcc $(CFLAGS) -c -o build/$@ $?

run: rv32emu build/$(BIN)
	@./rv32emu build/$(BIN)

clean:
	@$(RM) -rf build
