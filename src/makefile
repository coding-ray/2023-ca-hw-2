# Call this makefile by `make -f src/makefile CFLAGS=... INCLUDES=... <goal> ...`
# in the root working directory.

OBJS = $(addprefix build/obj/,$(patsubst %,%.o,$(INCLUDES)))

ASMS = $(addprefix build/asm/,$(patsubst %,%.s,$(INCLUDES)))
.PRECIOUS: $(ASMS)

CROSS_COMPILE = riscv-none-elf-

SED_FILES = \
	src/replace_main_ret.sed \
	src/replace_write_with_ecall.sed \
	src/replace_m_ext.sed

ASFLAGS = $(filter -march=% -mabi%,$(CFLAGS))
LDFLAGS = --oformat=elf32-littleriscv

BIN = is_palindrome.elf

all: clean make-build-dir $(BIN) run

asm: clean-obj make-build-dir $(BIN) run

make-build-dir:
	@mkdir -p build/obj build/asm

$(BIN): $(OBJS)
	@$(CROSS_COMPILE)ld $(LDFLAGS) -o build/$@ -T src/main.ld $^

build/obj/%.o: build/asm/%.s
	@$(CROSS_COMPILE)as -R $(ASFLAGS) -o $@ $^

build/asm/%.s: src/%.s
	@cp $^ $@

build/asm/%.s: src/%.c
	@$(CROSS_COMPILE)gcc $(CFLAGS) -S -o $@ $^
	@for i in $(SED_FILES); do \
		sed -f $$i -i $@; \
	done

run: build/$(BIN)
	./rv32emu $^

clean:
	@$(RM) -rf build

clean-obj:
	@$(RM) -rf build/obj