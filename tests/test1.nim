# This is just an example to get you started. You may wish to put all of your
# tests into a single file, or separate them into multiple `test1`, `test2`
# etc. files (better names are recommended, just make sure the name starts with
# the letter 't').
#
# To run these tests, simply execute `nimble test`.

import unittest, strutils

import proquint
test "Is consistent":
  for i in 0..1000:
    var 
      j = uint32(i)
      a = uint2quint(j)
      b = quint2uint(a)
    check b == j

proc match(h, q: string): bool =
  var
    i = uint32(parseHexInt(h))
    c = uint2quint(i)
  return c == q

test "Matches original":
  check match("0x7f000001", "lusab-babad")
  check match("0x3f54dcc1", "gutih-tugad")
  check match("0x3f760723", "gutuk-bisog")
  check match("0x8c62c18d", "mudof-sakat")
  check match("0x40ff06c8", "haguz-biram")
  check match("0x801e342d", "mabiv-gibot")
  check match("0x93437702", "natag-lisaf")
  check match("0xd43afd44", "tibup-zujah")
  check match("0xd82344d7", "tobog-higil")
  check match("0xd844e815", "todah-vobij")
  check match("0xc6518188", "sinid-makam")
  check match("0xc6e6ecc", "budov-kuras")
