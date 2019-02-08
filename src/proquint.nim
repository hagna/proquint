import strutils, strformat, os


let 
  cons = "bdfghjklmnprstvz"
  vowels = "aiou"

template handle_consonant() =
    j = i and 0xf0000000'u32
    i = i shl 4
    j = j shr 28
    result.add(cons[int(j)])

template handle_vowel() = 
    j = i and 0xC0000000'u32
    i = i shl 2
    j = j shr 30    
    result.add(vowels[int(j)])

proc uint2quint*(c: uint32): string = 
    ## Converts a uint to a pronounceable quintuplet or quint (https://arxiv.org/html/0901.4016).
    ## For example, "0x93437702" is "natag-lisaf".

    var
      i = c
      j: uint32

    handle_consonant
    handle_vowel
    handle_consonant
    handle_vowel
    handle_consonant

    result.add("-")

    handle_consonant
    handle_vowel
    handle_consonant
    handle_vowel
    handle_consonant

template ccs(ch: char, i: int) =
    if c == ch:
      result = result shl 4
      result += i

template vvs(ch: char, i: int) =
    if c == ch:
      result = result shl 2
      result += i

proc quint2uint*(s: string): uint32 = 
    ## Converts a quint to a uint.

    var
      c: char

    for i in 0..len(s)-1:
      c = s[i]
      ccs('b', 0)
      ccs('d', 1)
      ccs('f', 2)
      ccs('g', 3)

      ccs('h', 4)
      ccs('j', 5)
      ccs('k', 6)
      ccs('l', 7)

      ccs('m', 8)
      ccs('n', 9)
      ccs('p', 10)
      ccs('r', 11)

      ccs('s', 12)
      ccs('t', 13)
      ccs('v', 14)
      ccs('z', 15)

      vvs('a', 0)
      vvs('i', 1)
      vvs('o', 2)
      vvs('u', 3)

        
when isMainModule:
    for i, v in commandLineParams().pairs:
       var n = v
       if n[0] in cons:
           echo &"x{toHex(quint2uint(n))}"
       if v[0] == 'x':
           n = &"0{v}"
       if n[0..1] == "0x":
           var
             h = parseHexInt(n)
           echo uint2quint(uint32(h))
 

