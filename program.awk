BEGIN {
    FS=",";
    # Format the headings:
    # %-15s : use 15 characters for names, left justified (-)
    # %7s   : use 7 characters for averages
    FORMATHEADING = "%-15s%7s\n";
    # Note that we use printf here, not print
    printf FORMATHEADING, "Name", "Average"
    printf FORMATHEADING, repeated_char("-", 4), repeated_char("-", 7)
}
NR > 1 {
    INDIVIDUALSUM = 0;
    INDIVIDUALNUM = 0;
    for( i=3; i <= NF; i++ ) {
        if( $i != -1 ) {
            TESTSUM[i-2] += $i;
            TESTNUM[i-2] += 1;
            INDIVIDUALSUM += $i;
            INDIVIDUALNUM += 1;
            TEAMSUM[$2] += $i;
            TEAMNUM[$2] += 1;
        }
    }
    # Format averages
    # %-15s : 15 characters for names, left justified (-)
    # %7.2f :  7 characters for avg, of which 2 for decimals (.2)
    FORMATAVG = "%-15s%7.2f\n"
    printf FORMATAVG, $1, INDIVIDUALSUM/INDIVIDUALNUM;
}

END {
    for( idx in TESTSUM ) {
        AVG = TESTSUM[idx]/TESTNUM[idx]
        # Create a string to compute its length
        TESTSTR[idx] = sprintf("Average, Test %d: %5.2f", idx,  AVG)
        # Store the length of the longest string
        if( MAX < length(TESTSTR[idx]) )
            MAX = length(TESTSTR[idx])
    }
    # Print separator
    SEP = repeated_char("-", MAX);
    print SEP;
    # Print average by test
    for( i = 1; i <= 3; i++ ) {
        print TESTSTR[i]
    }
    print SEP;
    # Print average by team
    for( key in TEAMSUM ) {
        AVG = TEAMSUM[key]/TEAMNUM[key]
        printf "Average, %-6s: %5.2f\n", key, AVG
    }
}
# function declaration
function repeated_char( char, times ) {
    res = ""
    for( i=0; i < times; i++)
        res = res char # append char to res
    return res
}
