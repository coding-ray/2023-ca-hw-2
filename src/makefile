# Call this makefile by `make -f src/makefile` in the root working directory.

CROSS_COMPILE = riscv-none-elf-

# CFLAGS = -march=rv32i -mabi=ilp32 -Wall -Wextra -O0
CFLAGS = -march=rv32i_zicsr -mabi=ilp32 -Wall -Wextra -O0
# "zicsr" extension defines "__riscv_zicsr" in C

OBJS = \
	get-cycles.o \
	get-instret.o \
	main.o

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
