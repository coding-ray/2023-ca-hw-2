# reference: https://unix.stackexchange.com/a/26290

# old:
#   call write
# new:
#   # call write
#   li a7, 64
#   ecall

s/^\([ \t]*\)call[ \t]*write.*$/\1# call write\n\1li a7, 64\n\1ecall/g