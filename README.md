# printF
 tabular printing in red
 
 this syntax :
 ```
Red []
 
do load %printF.red

printF/underlined ["Some examples" [20] "This" [-14] "That" [-10] "A Rest" [-8 ] "When" [-12]] #"_"
printF ["none shown" [20] 345.2345 [-14 2 "$ " 'blank] 123.4567 [-10 3] none [-8 ] 2000-1-1 [-12]]
printF ["various 'blank" [20] 98765.7321 [-14 2 "$ " 'blank] -1.87654 [-10 3] 0 [-8 'blank] 2019-3-6 [-12]]
printF ["zero blank / not blank" [20] 0.0 [-14 2 "$ " 'blank] 0 [-10 3] -98 [-8 0 "" 'blank]]
printF ["a block shown" [20] [0 "xyz"] [-14] 0 [-10 3] -98 [-8 0 "" 'blank]]
printF/underlined ["too big float" [20] 98765444444.7321 [-14 2 "$ " 'blank] 1.87654 [-10 3] 54321 [-8 'blank] none [-12]] #"-"

str: printF/asString/underlined ["more underlined" [20] 345.2345 [-14 2 "$ " 'blank] 123.4567 [-10 3] 12345678 [-8 'blank] now/date [-12]] #"="
print [str]
 ```
 
 produces this report:
 ```
Some examples                  This       That   A Rest         When 
____________________________________________________________________
none shown                 $ 345.23    123.456            1-Jan-2000 
various 'blank           $ 98765.73     -1.876            6-Mar-2019 
blank / not blank                        0.000      -98 
a block shown             [0 "xyz"]      0.000      -98 
too big float        $ 98765444444.73      1.876    54321              
--------------------------------------------------------------------
more underlined            $ 345.23    123.456 12345678  20-Feb-2020 
====================================================================
 ```
