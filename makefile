PGM_NAME = is_palindrome
ASM_VERSION = v1-from-c
CROSS_COMPILE = riscv-none-elf-
CFLAGS = -Wall -Wextra
ASFLAGS = -march=rv32i -mabi=ilp32 # RV32I only
LDFLAGS = --oformat=elf32-littleriscv

test-c: clean build-dir src-c-to-asm asm-to-binary binary-to-elf run

test-s: clean build-dir src-asm-to-binary binary-to-elf run

build-dir:
	@mkdir -p build

src-c-to-asm:
	@$(CROSS_COMPILE)gcc -S src/$(PGM_NAME).c -o build/$(PGM_NAME).s $(ASFLAGS) $(CFLAGS)
	@sed -f src/replace_write_with_ecall.sed -i build/$(PGM_NAME).s
	@sed -f src/replace_main_ret.sed -i build/$(PGM_NAME).s
	@echo "[OK] C              -> RV32I assembly"

asm-to-binary:
	@$(CROSS_COMPILE)as -R $(ASFLAGS) -o build/$(PGM_NAME).o $(ASFLAGS) build/$(PGM_NAME).s
	@echo "[OK] RV32I assembly -> RV32I binary"

src-asm-to-binary:
	@$(CROSS_COMPILE)as -R $(ASFLAGS) -o build/$(PGM_NAME).o $(ASFLAGS) src/$(PGM_NAME)_$(ASM_VERSION).s
	@echo "[OK] RV32I assembly -> RV32I binary"

binary-to-elf:
	@$(CROSS_COMPILE)ld -o build/$(PGM_NAME).elf -T src/$(PGM_NAME).ld $(LDFLAGS) build/$(PGM_NAME).o
	@echo "[OK] RV32I binary   -> RV32I ELF\n"

run:
	./rv32emu build/$(PGM_NAME).elf

clean:
	@rm -rf build