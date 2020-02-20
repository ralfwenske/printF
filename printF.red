Red [
    Title: "Print formatted"
    File: %printf.red
    Author: "Ralf Wenske"
    Date: 20-Feb-2020
    Purpose: {
        Enable columnar printing or emitting string
    }
    Usage: {  
        printF/underlined ["Other" [] "This" [-14] "That" [-10] "A Rest" [-8 ] "When" [-12]] #"_"
        printF ["abcde" [] 345.2345 [-14 2 "$ " 'blank] 123.4567 [-10 3] none [-8 ] 2000-1-1 [-12]]
        printF ["fgh" [] 98765.7321 [-14 2 "$ " 'blank] -1.87654 [-10 3] 0 [-8 'blank] 2019-3-6 [-12]]
        printF ["some" [] 0.0 [-14 2 "$ " 'blank] 0 [-10 3] -98 [-8 0 "" 'blank]]
        printF ['aword [] [0 "xyz"] [-14] 0 [-10 3] -98 [-8 0 "" 'blank]]
        printF/underlined ["items" [] 98765444444.7321 [-14 2 "$ " 'blank] 1.87654 [-10 3] 54321 [-8 'blank] none [-12]] #"-"

        str: printF/asString/underlined ["abcde" [] 345.2345 [-14 2 "$ " 'blank] 123.4567 [-10 3] 12345678 [-8 'blank] now/date [-12]] #"="
        print [str]

    results in:

        Other              This       That   A Rest         When 
        ________________________________________________________
        abcde          $ 345.23    123.456            1-Jan-2000 
        fgh          $ 98765.73     -1.876            6-Mar-2019 
        some                         0.000      -98 
        aword         [0 "xyz"]      0.000      -98 
        items    $ 98765444444.73      1.876    54321              
        --------------------------------------------------------
        abcde          $ 345.23    123.456 12345678  20-Feb-2020 
        ========================================================
    }
]

_format: function ["return formatted val"
    val [integer! float! date! string! word! block! none! ]
    parms [block!] "[] or [(-)width decimals prefix 'blank] (-) --> right align" 
][
  blank: none <> find parms 'blank
  if blank [remove find parms 'blank]
  width: either parms/1 [parms/1][8]
  dec: either parms/2 [parms/2][0]
  pref: either parms/3 [parms/3][none]
  case/all [
    integer? val [val: to-float val]
    float? val [ 
        v1: form either ((absolute val) < 0.0000000001) [
            0.0
        ][
            val
        ]
      append v1 "000000000000"
      dp: index? find v1 "."
      decimals: (length? v1) - dp
      either decimals < dec [
        while [decimals < dec][
          append v1 "0"
          decimals: decimals + 1
        ]
      ][
        while [decimals > dec][
          take/last v1
          decimals: decimals - 1
        ]
        if dec = 0 [take/last v1]
      ]
      val1: v1
      if pref [val1: rejoin [pref val1]]
      if (blank and ((absolute val) < 0.0000000001)) [
          val1: pad "" width
      ]
    ]
    none? val [val1: #" "]
    date? val [val1: form val]
    string? val [val1: copy val]
    word? val [val1: form val]
    block? val [val1: mold val]
  ]
  either (width < 0) [
    return pad/left val1 (0 - width)
  ][
    return pad val1 width
  ]
]; format

printF: function ["print ( value [width decs prefix 'blank] ) pairs contained in a block"
    b [block!]
    /underlined ch [char!] "print extra line completely padded with ch"
    /asString "instead of printing return a string"
][
    res: copy ""
    foreach [v p] reduce b [
        append res _format v p
        append res " "
    ]
    if underlined [
        append res newline
        foreach [v p] reduce b [
            w: either (empty? p) [9][1 + absolute p/1]
            append res pad/with copy "" w ch
        ]
        take/last res
    ]
    either asString [res][print res]
]
