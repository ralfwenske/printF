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

printF/underlined ["Other" [] "This" [-14] "That" [-10] "A Rest" [-8 ] "When" [-12]] #"_"
printF ["abcde" [] 345.2345 [-14 2 "$ " 'blank] 123.4567 [-10 3] none [-8 ] 2000-1-1 [-12]]
printF ["fgh" [] 98765.7321 [-14 2 "$ " 'blank] -1.87654 [-10 3] 0 [-8 'blank] 2019-3-6 [-12]]
printF ["some" [] 0.0 [-14 2 "$ " 'blank] 0 [-10 3] -98 [-8 0 "" 'blank]]
printF ['aword [] [0 "xyz"] [-14] 0 [-10 3] -98 [-8 0 "" 'blank]]
printF/underlined ["items" [] 98765444444.7321 [-14 2 "$ " 'blank] 1.87654 [-10 3] 54321 [-8 'blank] none [-12]] #"-"

str: printF/asString/underlined ["abcde" [] 345.2345 [-14 2 "$ " 'blank] 123.4567 [-10 3] 12345678 [-8 'blank] now/date [-12]] #"="
print [str]