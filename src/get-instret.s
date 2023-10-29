.text

.globl get_instret
.align 2
.ifdef __riscv_zicsr
get_instret:
    csrr a1, instreth
    csrr a0, instret
    csrr a2, instreth
    bne a1, a2, get_instret
    ret

.size get_instret,.-get_instret
.endif # __riscv_zicsr
