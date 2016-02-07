//
//  snakes-and-ladders.swift
//  
//
//  Created by James Gillin on 2/7/16.
//
//

var minMovesToSpot = [Int]()
var shortcuts = [Int?]()

func play(atSpot: Int) {
  let k = minMovesToSpot[atSpot]
  for y in 1...6 { //from this spot, check all 6 spots we could land on with 1 die roll
    var spotToCheck = atSpot + y
    //simulates wasted rolls, e.g. being on 97 and rolling > 3
    if spotToCheck > 100 { break }
    //if we'd land on a shortcut, replace that spot with its destination spot
    if shortcuts[spotToCheck] != nil { spotToCheck = shortcuts[spotToCheck]!}
    let destK = minMovesToSpot[spotToCheck]
    if destK < 0 {
      //first time we found a way to that spot. Set its minMoves and recur
      minMovesToSpot[spotToCheck] = k + 1
      play(spotToCheck)
    }
    else if (k + 1) < minMovesToSpot[spotToCheck] {
      //we did better than a previous path to that spot. Update its minMoves and recur
      minMovesToSpot[spotToCheck] = k + 1
      play(spotToCheck)
    }
    //else, we didn't do better for getting to spotToCheck, so don't recur
  }
}

let t = Int(readLine()!)! //number of games to play
for x in 1...t {
  //for readability we will use 1...100 instead of 0...99, so arrays will be of size 101 not 100
  minMovesToSpot = [Int](count: 101, repeatedValue: -1)
  minMovesToSpot[1] = 0
  //snakes or ladders; if spot p has a snake/ladder leading to spot q, then shortcuts[p] = q
  shortcuts = [Int?](count: 101, repeatedValue: nil)
  
  for _ in 1...2 {
    //we store ladders identically to snakes, and they're input in the same format,
    //so just run this twice: 1st for ladders, then for snakes
    let n = Int(readLine()!)!
    if n > 0 {
      for y in 1...n {
        let shortcut = readLine()!.characters.split(" ").map{Int(String($0))!}
        let origin = shortcut[0]
        let dest = shortcut[1]
        shortcuts[origin] = dest
      }
    }
  }
  play(1)
  print(minMovesToSpot[100])
}