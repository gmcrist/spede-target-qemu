# Target information
set serial baud 38400

source /opt/spede/lib/gdb_helpers.py

# Display/output configuration
set width 0
set height 0
set output-radix 0x10
set input-radix 0x10

set print pretty on
set prompt \033[31mSPEDE GDB$ \033[0m

set confirm off
set verbose off

# Sets a temporary breakpoint at 'main'
tbreak main

# Disable the "run" command since we do not use it (need to use continue)
define run
    continue
end
document run
    Continues running the program
end

# Print stack frame details
#define frame
#    info frame
#    info args
#    info locals
#end
#document frame
#Prints the stack frame details
#end

# Display the last error reason from GDB
define reason
    printf "CPU vector 0x%x, code 0x%x\n", gdb_i386vector, _gdb_i386errcode
end
document reason
Prints the interrupt vector and error code from the CPU (via GDB stub)
end

define cls
    shell clear
end
document cls
Clears the console/screen
end

# Execute to breakpoint at 'main'
continue

