*> Author: Jonas Bakelaar (0964977)
*> Date: March 24, 2018

identification division.
program-id. romanNumeralConverter.

environment division.
input-output section.
file-control.
select ifile assign to dynamic fileName
    organization is line sequential.
 
data division.
file section.
fd ifile.
01 input-record.
    02 numeralString pic X(30).
working-storage section.
77 eof-switch pic 9 value 1.
01 out-record.
    05 out1 pic X(8) value "string =".
    05 filler pic X.
    05 out2 pic X(30).
77 romanNumerals pic X(30).
77 i pic 99.
77 j pic 99.
77 k pic 99.
77 romanNumeralsLength pic 9(3).
77 romanNumeralsSum pic S9(8) usage is computational. *> Variable for actual sum calculation
77 romanNumeralsSumOutput pic Z(9). *> The final sum, formatted for correct output (e.g. kill sign and trailing 0's...)
77 userString pic X(30).
77 userChoice pic X(1).
77 fileName pic X(30).
77 incorrectInput pic 9.

procedure division.
    perform getUserChoice
        until userChoice is equal to "Q".
    stop run.

*>---User input stuff---

*>Take user choice (Enter string, read file, or quit)
getUserChoice.
    display "Would you like to enter a string (S) or read in a file (R)? (Q to quit)".
    accept userChoice.
    if userChoice is equal to "S"
        perform enterString
    else if userChoice is equal to "R"
        perform enterFile
    else if userChoice is equal to "Q"
        set j to j *>Stop the loop
    else
        display "You must choose appropriately!"
        perform getUserChoice
    end-if.
       
enterString.
    display "enter a string!".
    accept userString.
    move userString to romanNumerals.
    perform convert.

enterFile.
    display "enter file!".
    accept fileName.
    perform useFile.
    
*>---File Subprograms---

*>Calls the loop that calculates the total for each line of the file
useFile.
    open input ifile.
    
    move 1 to eof-switch.
    
    perform calculateFileLine
        until eof-switch is equal to zero.

    close ifile.

*>Reads a line from the file, calls conversion functionality
calculateFileLine.
    read ifile into input-record
        at end move zero to eof-switch
    end-read.
    if eof-switch is not equal to zero
        move numeralString to out2
        move numeralString to romanNumerals
        perform convert
    end-if.


*>---Main conversion functions---
    
*>Calls conversion functions, prints final sum
convert.
    perform toLowerCase.
    move 1 to i.
    move 1 to k.
    move 0 to incorrectInput.
    perform checkInput 
        until i is equal to 30.
    if incorrectInput is equal to 1
        display "Invalid Roman Numeral: "romanNumerals(k:1)
    else 
        move 0 to romanNumeralsSum
        move 0 to romanNumeralsSumOutput
        move 0 to i
        move 0 to k
        perform addingLoop
            until i is equal to 30
        move romanNumeralsSum to romanNumeralsSumOutput
        perform toUpperCase
        display romanNumerals" is equal to: "romanNumeralsSumOutput
    end-if.

*>Checks user input to make sure it's a valid Roman Numeral
checkInput.
    if romanNumerals(i:1) is equal to " "
        move i to i
    else if romanNumerals(i:1) is equal to "i"
        move i to i
    else if romanNumerals(i:1) is equal to "v"
        move i to i
    else if romanNumerals(i:1) is equal to "x"
        move i to i
    else if romanNumerals(i:1) is equal to "l"
        move i to i
    else if romanNumerals(i:1) is equal to "c"
        move i to i
    else if romanNumerals(i:1) is equal to "d"
        move i to i
    else if romanNumerals(i:1) is equal to "m"
        move i to i
    else
        move 1 to incorrectInput
        move i to k
    end-if.
    add 1 to i.
    

*>Loop to add the roman numerals together, calculate the total sum
addingLoop.
    move i to k.
    add 1 to k.
    if romanNumerals(i:1) is equal to " "
        move i to k
    else if romanNumerals(i:1) is equal to "i"
        if i is equal to 30
            add 1 to romanNumeralsSum
        else
            if romanNumerals(k:1) is equal to "i"
                add 1 to romanNumeralsSum
            else if romanNumerals(k:1) is equal to " "
                add 1 to romanNumeralsSum
            else
                subtract 1 from romanNumeralsSum
            end-if
        end-if
    else if romanNumerals(i:1) is equal to "v"
        if i is equal to 30
            add 5 to romanNumeralsSum
        else
            if romanNumerals(k:1) is equal to "i"
                add 5 to romanNumeralsSum
            else if romanNumerals(k:1) is equal to "v"
                add 5 to romanNumeralsSum
            else if romanNumerals(k:1) is equal to " "
                add 5 to romanNumeralsSum
            else
                subtract 5 from romanNumeralsSum
            end-if
        end-if
    else if romanNumerals(i:1) is equal to "x"
        if i is equal to 30
            add 10 to romanNumeralsSum
        else
            if romanNumerals(k:1) is equal to "i"
                add 10 to romanNumeralsSum
            else if romanNumerals(k:1) is equal to "v"
                add 10 to romanNumeralsSum
            else if romanNumerals(k:1) is equal to "x"
                add 10 to romanNumeralsSum
            else if romanNumerals(k:1) is equal to " "
                add 10 to romanNumeralsSum
            else
                subtract 10 from romanNumeralsSum
            end-if
        end-if
    else if romanNumerals(i:1) is equal to "l"
        if i is equal to 30
            add 50 to romanNumeralsSum
        else
            if romanNumerals(k:1) is equal to "i"
                add 50 to romanNumeralsSum
            else if romanNumerals(k:1) is equal to "v"
                add 50 to romanNumeralsSum
            else if romanNumerals(k:1) is equal to "x"
                add 50 to romanNumeralsSum
            else if romanNumerals(k:1) is equal to "l"
                add 50 to romanNumeralsSum
            else if romanNumerals(k:1) is equal to " "
                add 50 to romanNumeralsSum
            else
                subtract 50 from romanNumeralsSum
            end-if
        end-if
    else if romanNumerals(i:1) is equal to "c"
        if i is equal to 30
            add 100 to romanNumeralsSum
        else
            if romanNumerals(k:1) is equal to "i"
                add 100 to romanNumeralsSum
            else if romanNumerals(k:1) is equal to "v"
                add 100 to romanNumeralsSum
            else if romanNumerals(k:1) is equal to "x"
                add 100 to romanNumeralsSum
            else if romanNumerals(k:1) is equal to "l"
                add 100 to romanNumeralsSum
            else if romanNumerals(k:1) is equal to "c"
                add 100 to romanNumeralsSum
            else if romanNumerals(k:1) is equal to " "
                add 100 to romanNumeralsSum
            else
                subtract 100 from romanNumeralsSum
            end-if
        end-if
    else if romanNumerals(i:1) is equal to "d"
        display "Dealing with 500!"
        if i is equal to 30
            add 500 to romanNumeralsSum
        else
            if romanNumerals(k:1) is equal to "i"
                add 500 to romanNumeralsSum
            else if romanNumerals(k:1) is equal to "v"
                add 500 to romanNumeralsSum
            else if romanNumerals(k:1) is equal to "x"
                add 500 to romanNumeralsSum
            else if romanNumerals(k:1) is equal to "l"
                add 500 to romanNumeralsSum
            else if romanNumerals(k:1) is equal to "c"
                add 500 to romanNumeralsSum
            else if romanNumerals(k:1) is equal to "d"
                add 500 to romanNumeralsSum
            else if romanNumerals(k:1) is equal to " "
                add 500 to romanNumeralsSum
            else
                subtract 500 from romanNumeralsSum
            end-if
        end-if
    else if romanNumerals(i:1) is equal to "m"
        if i is equal to 30
            add 1000 to romanNumeralsSum
        else
            if romanNumerals(k:1) is equal to "i"
                add 1000 to romanNumeralsSum
            else if romanNumerals(k:1) is equal to "v"
                add 1000 to romanNumeralsSum
            else if romanNumerals(k:1) is equal to "x"
                add 1000 to romanNumeralsSum
            else if romanNumerals(k:1) is equal to "l"
                add 1000 to romanNumeralsSum
            else if romanNumerals(k:1) is equal to "c"
                add 1000 to romanNumeralsSum
            else if romanNumerals(k:1) is equal to "d"
                add 1000 to romanNumeralsSum
            else if romanNumerals(k:1) is equal to "m"
                add 1000 to romanNumeralsSum
            else if romanNumerals(k:1) is equal to " "
                add 1000 to romanNumeralsSum
            else
                subtract 1000 from romanNumeralsSum
            end-if
        end-if
    end-if.
    add 1 to i.

*>---Helper subprogram(s)---

toLowerCase.
    move Function Lower-case(romanNumerals) to romanNumerals.
    
toUpperCase.
    move Function Upper-case(romanNumerals) to romanNumerals.
