import std/sequtils

proc loadFile(file: File): seq[(char, char)] =
  var line: string
  while file.readLine(line):
    result.add((line[0], line[2]))

proc sum(sequence: seq[int]): int =
  return sequence.foldl(a + b)

proc calculateRound(round: (char, char)): int =
  let shapeScore = case round[1]
   of 'X': 
    1
   of 'Y':
    2
   of 'Z':
    3
   else:
    raise newException(Exception, "Bad input")
  let roundScore = 
    if (round[0] == 'A' and round[1] == 'X') or
       (round[0] == 'B' and round[1] == 'Y') or
       (round[0] == 'C' and round[1] == 'Z'):
      3
    elif (round[0] == 'A' and round[1] == 'Y') or
         (round[0] == 'B' and round[1] == 'Z') or
         (round[0] == 'C' and round[1] == 'X'):
      6
    else:
      0
  return shapeScore + roundScore

proc calculateRoundModified(round: (char,char)): int =
  let modifiedRound2 = case round[1]
    of 'X': # lose
      case round[0]
        of 'A':
          'Z'
        of 'B':
          'X'
        of 'C':
          'Y'
        else:
          raise newException(Exception, "Bad input")
    of 'Y': # draw
     case round[0]
        of 'A':
          'X'
        of 'B':
          'Y'
        of 'C':
          'Z'
        else:
          raise newException(Exception, "Bad input")
    of 'Z': # win
     case round[0]
        of 'A':
          'Y'
        of 'B':
          'Z'
        of 'C':
          'X'
        else:
          raise newException(Exception, "Bad input")
    else:
      raise newException(Exception, "Bad input")
  return calculateRound((round[0], modifiedRound2))

proc calculateScore(guide: seq[(char, char)]): int =
  guide.map(calculateRound).sum  

proc calculateScoreModified(guide: seq[(char, char)]): int =
  guide.map(calculateRoundModified).sum 

let f = open("input.txt")
let data = loadFile(f)
echo(calculateScore(data))
echo(calculateScoreModified(data))