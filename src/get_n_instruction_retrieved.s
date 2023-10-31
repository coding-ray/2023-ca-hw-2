.text

.globl get_n_instruction_retrieved
.align 2
get_n_instruction_retrieved:
    csrr a1, instreth
    csrr a0, instret
    csrr a2, instreth
    bne a1, a2, get_n_instruction_retrieved
    ret

.size get_n_instruction_retrieved,.-get_n_instruction_retrieved
