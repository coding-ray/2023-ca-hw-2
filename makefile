# "zicsr" extension defines "__riscv_zicsr" in C and assembly.
CFLAGS_P = -march=rv32im_zicsr -mabi=ilp32 -Wall -Wextra -O0

INCLUDES_P = \
	get_n_csr_cycle \
	get_n_instruction_retrieved \
	main

CFLAGS_S = -march=rv32i -mabi=ilp32 -Wall -Wextra -O0

INCLUDES_S = \
	main

GOALS_IN_THIS_MAKEFILE = \
	p \
	performance \
	s \
	size \
	ap \
	assembly-performance

GOALS_FOR_NEXT_MAKEFILE = $(filter-out $(GOALS_IN_THIS_MAKEFILE),$(MAKECMDGOALS))

p: performance
performance:
	@make --no-print-directory -f src/makefile $(GOALS_FOR_NEXT_MAKEFILE) \
		CFLAGS="$(CFLAGS_P)" INCLUDES="$(INCLUDES_P)"

s: size
size:
	@make --no-print-directory -f src/makefile $(GOALS_FOR_NEXT_MAKEFILE) \
		CFLAGS="$(CFLAGS_S)" INCLUDES="$(INCLUDES_S)"
	@riscv-none-elf-size build/*.elf

# handle excess goals
ifneq ($(GOALS_FOR_NEXT_MAKEFILE), )
%:
	@make --no-print-directory -f src/makefile $(GOALS_FOR_NEXT_MAKEFILE) \
		CFLAGS="$(CFLAGS_P)" INCLUDES="$(INCLUDES_P)"
endif