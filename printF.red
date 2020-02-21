Red [
    Title: "Print formatted"
    File: %printf.red
    Author: "Ralf Wenske"
    Date: 20-Feb-2020
    Changes: {
      21-Feb-2020: /underlined replaced with leading/trailing char! 
                    --> padded char line above/below
    }
    Purpose: {
        Enable columnar printing or emitting string
    }
    Usage: {  
      do load %printF.red
      foreach blk [
        [#"=" "Some examples" [20] "This" [-14] "That" [-10] "A Rest" [-8 ] "When" [-12] #"_"]
        ["none shown" [] 345.2345 [-14 2 "$ " 'blank] 123.4567 [-10 3] none [-8 ] 2000-1-1 [-12]]
        ["various 'blank" [] 98765.7321 [-14 2 "$ " 'blank] -1.87654 [-10 3] 0 [-8 'blank] 2019-3-6 [-12]]
        ["blank / not blank" [] 0.0 [-14 2 "$ " 'blank] 0 [-10 3] -98 [-8 0 "" 'blank]]
        ["a block shown" [] [0 "xyz"] [-14] 0 [-10 3] -98 [-8 0 "" 'blank]]
        ["too big float" [] 98765444444.7321 [-14 2 "$ " 'blank] 1.87654 [-10 3] 54321 [-8 'blank] none [-12] #"-"]
        ["more underlined" [20] 345.2345 [-14 2 "$ " 'blank] 123.4567 [-10 3] 12345678 [-8 'blank] now/date [-12] #"="]
      ] [printf blk]  

    results in:

      ====================================================================
      Some examples                  This       That   A Rest         When 
      ____________________________________________________________________
      none shown                 $ 345.23    123.456            1-Jan-2000 
      various 'blank           $ 98765.73     -1.876            6-Mar-2019 
      blank / not blank                        0.000      -98 
      a block shown             [0 "xyz"]      0.000      -98 
      too big float        $ 98765444444.73      1.876    54321              
      --------------------------------------------------------------------
      more underlined            $ 345.23    123.456 12345678  21-Feb-2020 
      ====================================================================
    }
]
defaultWidth: 20 ;;;; override if needed

format: function ["return formatted val"
    val [integer! float! date! string! word! block! none! ]
    parms [block!] "[] or [(-)width decimals prefix 'blank] (-) --> right align" 
][
  blank: none <> find parms 'blank
  if blank [remove find parms 'blank]
  width: either parms/1 [parms/1][defaultwidth]
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
    b [block!] "leading / trailing char! creates above / below line padded with ch"
    /asString "instead of printing return a string"
][
    if char? first b [
      abovelinedch: take b
    ]
    if char? last b [
      belowlinedch: take/last b
    ]
    totalwidth: 0
    res: copy ""
    foreach [v p] reduce b [
        append res format v p
        append res " "
        totalwidth: totalwidth + 1 + either p/1 [absolute p/1][defaultwidth]
    ]
    totalwidth: totalwidth - 1
    line: copy ""
    if char? abovelinedch [
        insert res rejoin [pad/with copy "" totalwidth abovelinedch newline]
    ]
    if char? belowlinedch [
        append res rejoin [newline pad/with copy "" totalwidth belowlinedch]
    ]
    append res newline
    either asString [res][prin res]
]; printF
