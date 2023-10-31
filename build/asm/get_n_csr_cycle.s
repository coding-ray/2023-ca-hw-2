.text

.globl get_n_csr_cycle
.align 2
get_n_csr_cycle:
    csrr a1, cycleh
    csrr a0, cycle
    csrr a2, cycleh
    bne a1, a2, get_n_csr_cycle
    ret

.size get_n_csr_cycle,.-get_n_csr_cycle
