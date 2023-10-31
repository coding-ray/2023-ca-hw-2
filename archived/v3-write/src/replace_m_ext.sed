# reference: https://unix.stackexchange.com/a/26290

# old:
#   call	__udivdi3 # quotient (a0) = dividend (a0) / divisor (a2)
# new:
#   divu	a0,a0,a2

s/^\([ \t]*\)call[ \t]*__udivdi3.*$/\1divu	a0,a0,a2/g

# old:
#   call	__umoddi3 # remainder (a0) = dividend (a0) % divisor (a2)
# new:
#   ...
#   remu	a0,a0,a2
#   ...

s/^\([ \t]*\)call[ \t]*__umoddi3.*$/\1remu	a0,a0,a2/g