# reference: https://unix.stackexchange.com/a/26290

# old:
#   jr ra
#   .size	main, .-main
# new:
#   # exit program
#   li a7, 93           # "exit" syscall
#   add a0, x0, 0       # Use 0 return code
#   ecall               # invoke syscall to terminate the program
#   .size	main, .-main

/^[ \t]*jr[ \t]*ra.*$/{
  $!{ N        # append the next line when not on the last line
    s/^\([ \t]*\)jr[ \t]*ra.*\n\([ \t]*\.size[ \t]*main,[ \t]*\.-main.*\)$/\1# exit program\n\1li a7, 93           # "exit" syscall\n\1add a0, x0, 0       # Use 0 return code\n\1ecall               # invoke syscall to terminate the program\n\2/

    t sub-yes # branch_on_substitute (goto label :sub-yes)
    :sub-not  # a label (not essential; here to self document)
              # if no substituion, print only the first line
    P         # pattern_first_line_print
    D         # pattern_ltrunc(line+nl)_top/cycle
    :sub-yes
    # fall through to final auto-pattern_print (2 lines)
  }
}