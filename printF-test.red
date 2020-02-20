Red [
    Title: "Print formatted"
    File: %printf.red
    Author: "Ralf Wenske"
    Date: 20-Feb-2020
    Purpose: {
        testing of %printF.red
    }
]

do load %printF.red

printF/underlined ["Some examples" [20] "This" [-14] "That" [-10] "A Rest" [-8 ] "When" [-12]] #"_"
printF ["none shown" [20] 345.2345 [-14 2 "$ " 'blank] 123.4567 [-10 3] none [-8 ] 2000-1-1 [-12]]
printF ["various 'blank" [20] 98765.7321 [-14 2 "$ " 'blank] -1.87654 [-10 3] 0 [-8 'blank] 2019-3-6 [-12]]
printF ["blank / not blank" [20] 0.0 [-14 2 "$ " 'blank] 0 [-10 3] -98 [-8 0 "" 'blank]]
printF ["a block shown" [20] [0 "xyz"] [-14] 0 [-10 3] -98 [-8 0 "" 'blank]]
printF/underlined ["too big float" [20] 98765444444.7321 [-14 2 "$ " 'blank] 1.87654 [-10 3] 54321 [-8 'blank] none [-12]] #"-"

str: printF/asString/underlined ["more underlined" [20] 345.2345 [-14 2 "$ " 'blank] 123.4567 [-10 3] 12345678 [-8 'blank] now/date [-12]] #"="
print [str]