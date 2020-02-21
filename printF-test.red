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

demo1: does [
    res: copy ""
    foreach blk [
        [#"=" "Some examples" [20] "This" [-14] "That" [-10] "A Rest" [-8 ] "When" [-12] #"_"]
        ["none shown" [20] 345.2345 [-14 2 "$ " 'blank] 123.4567 [-10 3] none [-8 ] 2000-1-1 [-12]]
        ["various 'blank" [20] 98765.7321 [-14 2 "$ " 'blank] -1.87654 [-10 3] 0 [-8 'blank] 2019-3-6 [-12]]
        ["blank / not blank" [20] 0.0 [-14 2 "$ " 'blank] 0 [-10 3] -98 [-8 0 "" 'blank]]
        ["a block shown" [20] [0 "xyz"] [-14] 0 [-10 3] -98 [-8 0 "" 'blank]]
        ["too big float" [20] 98765444444.7321 [-14 2 "$ " 'blank] 1.87654 [-10 3] 54321 [-8 'blank] none [-12] #"-"]
        ["more underlined" [20] 345.2345 [-14 2 "$ " 'blank] 123.4567 [-10 3] 12345678 [-8 'blank] now/date [-12] #"="]
    ] [append res printf/asString blk]
    res
]; demo1

demo2: does [
    rdm: does [reduce [random "abcdefgh" random 1000 random 10000.0]]
    res: copy printf/asString [#"=" "FieldnameA" [20] "FieldnameB" [-10] "FieldnameC" [-14] #"-"]
    sum: copy [0 0]
    loop 3 [
        rdm-blk: rdm[] 
        append res printf/asString [rdm-blk/1 [20] rdm-blk/2 [-10] rdm-blk/3 [-14 4 "$ "]]
        sum/1: sum/1 + rdm-blk/2    
        sum/2: sum/2 + rdm-blk/3
    ]
    append res printF/asString [#"-" "TOTAL:" [20] sum/1 [-10] sum/2 [-14 4 "$ "] #"="]
]

s-demo1: rejoin ["demo1: " mold :demo1]
s-demo2: rejoin ["demo2: " mold :demo2]

win: layout compose/deep [
    title "printF - create tabular reports quickly"
    size 1000x600
    tabp1: tab-panel  [
        "Demo 1" [
            below            
            demo1-area1: area (s-demo1) 1000x280 font-name "Courier" font-size 11
                react [face/size/x: face/parent/parent/size/x - 40 ]
            demo1-area2: area (demo1) font-name "Courier" font-size 11
                react [face/size: face/parent/parent/size - 40x360 ]
        ]
        "Demo 2" [
            below            
            demo2-area1: area (s-demo2) 960x190 font-name "Courier" font-size 11
                react [face/size/x: face/parent/parent/size/x - 40 ]
            demo2-area2: area (demo2) font-name "Courier" font-size 11
                react [face/size: face/parent/parent/size - 40x270 ]
        ]
    ] react [face/size: face/parent/size - 20x20 ]
    do [
        demo1-area1/text :demo1
    ]
] ;react [face/size: face/parent/size ]

probe mold :demo1

view/flags win ['resize]