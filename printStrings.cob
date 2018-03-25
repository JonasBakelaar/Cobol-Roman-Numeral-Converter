identification division.
program-id. printStrings.

environment division.
input-output section.
file-control.
select ifile assign to "file.txt"
    organization is line sequential.

data division.
file section.
fd ifile.
01 input-record.
    02 numeralString pic X(20).
working-storage section.
77 eof-switch pic 9 value 1.
01 out-record.
    05 out1 pic X(8) value "string =".
    05 filler pic X.
    05 out2 pic X(20).
77 romanNumerals pic X(5).
77 userChoice pic X(1).

procedure division.
    
    open input ifile.
    
    perform print-loop
        until eof-switch is equal to zero.
    
    print-loop.
        read ifile into input-record
            at end move zero to eof-switch
        end-read.
        if eof-switch is not equal to zero
            move numeralString to out2
            display out-record
        end-if.
    close ifile.

