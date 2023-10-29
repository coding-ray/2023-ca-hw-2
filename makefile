# "zicsr" extension defines "__riscv_zicsr" in C and assembly.
CFLAGS_P = -march=rv32i_zicsr -mabi=ilp32 -Wall -Wextra -O0

OBJS_P = \
	get-cycles.o \
	get-instret.o \
	main.o

CFLAGS_S = -march=rv32i -mabi=ilp32 -Wall -Wextra -O0

OBJS_S = \
	main.o

p: performance
performance:
	@make --no-print-directory -f src/makefile \
		CFLAGS="$(CFLAGS_P)" OBJS="$(OBJS_P)"

s: size
size:
	@riscv-none-elf-size build/*.elf
	@make --no-print-directory -f src/makefile \
		CFLAGS="$(CFLAGS_S)" OBJS="$(OBJS_S)"