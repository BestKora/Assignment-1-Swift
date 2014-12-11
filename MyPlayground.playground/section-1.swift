// Playground - noun: a place where people can play

import Foundation
import Accelerate

var str = "Hello, playground"
//====

enum Suit {
    case Clubs, Diamonds, Hearts, Spades
}

enum Rank {
    case Jack, Queen, King, Ace
    case Num(Int)
}

struct Card1 {
    let suit: Suit
    let rank: Rank
}


/*
- Generate an array of tuples of 2 card subsequences by zipping the hand array with itself (minus the first element)
- Map over the array examining each pair for value-contributing combinations in a switch statement
- Sum all resulting values
*/
func countHand(hand: [Card1]) -> Int {
    return Array(Zip2(hand, dropFirst(hand))).map{(card1: Card1, card2: Card1)->Int in
        switch (card1.suit, card1.rank, card2.rank) {
        case (.Hearts, _, .Num(let numRank)) where numRank % 2 == 1:
            return 2 * numRank
        case (.Diamonds, .Num(5), .Ace):
            return 100
        default:
            return 0
        }}.reduce(0, +)
}

countHand([
    Card1(suit:.Hearts, rank:.Num(10)),
    Card1(suit:.Hearts, rank:.Num(6)),
    Card1(suit:.Diamonds, rank:.Num(5)),
    Card1(suit:.Clubs, rank:.Ace),
    Card1(suit:.Diamonds, rank:.Jack)
    ])
//=====

//class representing card.
class Card{
    var contents: String
    var isChosen: Bool = false
    var isMatched:Bool = false
    
    init(contents:String) {
        self.contents = contents
    }
    
    func description() ->String
    {
        return self.contents;
    }
    
    
    func match(otherCards: [Card]) -> Int {
        var score = 0
        for card in otherCards {
            if self.contents == card.contents {
                score = 1
            }
        }
        return score
    }
}
// A class representing Playing card.
class PlayingCard: Card {
    
    var suit: String = "?" {
    didSet {
        if  !contains(PlayingCard.validSuits(), suit) {
            suit = "?"
        }
        super.contents = PlayingCard.rankStrings()[self.rank]+self.suit
    }
    }
    
    var rank: Int = 0 {
    didSet {
        if rank > PlayingCard.maxRank() || rank < 0 {
            rank = 0
        }
        super.contents = PlayingCard.rankStrings()[self.rank]+self.suit
    }
    }
    
    init(suit s:String, rank r:Int) {
        self.rank = 0
        if r <=  PlayingCard.maxRank() && r >= 0 {
            self.rank = r
        }
        self.suit = "?"
        
        if  contains(PlayingCard.validSuits(), s) {
            self.suit = s
        }
        super.init(contents: PlayingCard.rankStrings()[self.rank]+self.suit)
        super.contents = PlayingCard.rankStrings()[self.rank]+self.suit
    }
    
    class func rankStrings() -> [String] {
        
        return  ["?", "A", "2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K"];
        
    }
    
    class func validSuits() -> [String] {
        return ["♥️", "♦️", "♠️", "♣️"]
    }
    
    class func maxRank() -> Int {
        
        return PlayingCard.rankStrings().count-1;
    }

    override func match(otherCards: [Card]) -> Int {
        var score = 0
        var numMatches = 0
        var numCards = otherCards.count
        
        if numCards > 0
        {
            for  i in 0..<numCards{
                var card1:PlayingCard? = otherCards[i] as? PlayingCard
                if card1 != nil {
                    for  j in i+1..<numCards {
                        var card2:PlayingCard? = otherCards[j] as? PlayingCard
                        if card2 != nil {
                            // check for the same suit
                            if card1!.suit == card2!.suit {
                                score += 1;
                                numMatches++;
                            }
                            // check for the same rank
                            if card1!.rank == card2!.rank {
                                score += 4;
                                numMatches++;
                            }
                        }
                    }
                }
            }
            
            if numMatches < (numCards - 1)
            {score = 0}
        }
        return score;
    }

}

func == (v1:Card, v2:Card) -> Bool {
    return v1.contents.isEqual(v2.contents)
}
extension Card : Equatable {
}

var pcard1:PlayingCard = PlayingCard (suit: "♠️",rank: 8)
var pcard2:PlayingCard = PlayingCard (suit: "♥️",rank: 8)
var pcard3:PlayingCard = PlayingCard (suit: "♥️",rank: 9)
var pcard4:PlayingCard = PlayingCard (suit: "♦️",rank: 9)

var otherCards:[PlayingCard] = [pcard1,pcard2,pcard3,pcard4]


let aaa = Array(Zip2(otherCards, dropFirst(otherCards)))
println(" aaa \(aaa)")

var arr = Array(otherCards[1...3])
let nn = pcard1.match(arr)

let numCards = otherCards.count
for nn in otherCards {
    let index = find(otherCards, nn)! + 1
    var Res = otherCards[index..<numCards].map {$0.rank  == nn.rank ?1 :0}.reduce(0) {$0  + $1}
    println("\(index) \(nn.contents), свертка1 \(Res)")
}
var scoreR = otherCards.reduce(0) {(var1:Int,var2:PlayingCard) -> Int in
    if let index = find(otherCards, var2){
        return  var1 + otherCards[(index + 1)..<numCards].map {$0.rank  == var2.rank ?1 :0}.reduce(0) {$0  + $1}}
        return 0}
var scoreS = otherCards.reduce(0) {(var1:Int,var2:PlayingCard) -> Int in
    if let index = find(otherCards, var2){
        return var1 + otherCards[(index + 1)..<numCards].map {$0.suit  == var2.suit ?1 :0}.reduce(0) {$0  + $1}}
        return 0}
var score = (scoreR + scoreS)>=(numCards-1) ?(scoreR + 4*scoreS) :0
var score5 = otherCards.reduce(0){(var1:Int,var2:PlayingCard) -> Int in
    if let index = find(otherCards, var2){
        return (var1 + index)}
    return 0
}
println("\(scoreR), \(scoreS) \(score5) свертка2")

let usa = "\u{0001F1FA}U0001F1F8"     // -> US flag ("US")
let usaReversed = "" + reverse(usa)

let d:Double = -2.0
var ui64: UInt64 = unsafeBitCast(d,UInt64.self)

func showDoubleEnc(d: Double, descr: String) {
    var ui64 : UInt64 = unsafeBitCast(d,UInt64.self)
    var s = descr + ":\n  bin: "
    for i in reverse(0...63) {
        if (((UInt64(1) << UInt64(i)) & ui64) > 0) { s += "1" }
        else { s += "0" }
        if (i & 7 == 0) { s += " " }
    }
    s += "\n  hex: "
    for i in reverse(0...7) {
        s += String(format: "%02x ", ((ui64 >> (8 * UInt64(i))) & 0xFF))
    }
    println(s + "\n")
}
showDoubleEnc(0.0, "0")
showDoubleEnc(-0.0, "-0")
showDoubleEnc(1.0, "1.0")
showDoubleEnc(-2.0, "-2.0")
showDoubleEnc(1.0000000000000002, "Smallest number > 1")
showDoubleEnc(Double.infinity, "inf")
showDoubleEnc(Double.NaN, "nan")
showDoubleEnc(pow(2.0, -1022), "Min normal positive double")
showDoubleEnc(pow(2.0, -1022 - 52), "Min subnormal positive double")
//======
enum AccelerateUnaryOperation {
    case Sqrt
    case Ceil
}
 
enum AccelerateBinaryOperation {
    case Add
}
 
func map(input: [Double], operation: AccelerateUnaryOperation) -> [Double] {
    var results = [Double](count:input.count, repeatedValue:0.0)
    let count = [Int32(input.count)]
    switch operation {
    case .Sqrt:
      vvsqrt(&results, input, count)
    case .Ceil:
        vvceil(&results, input, count)
    }
    
    return results
}
 
func zipWith(left: [Double], right: [Double], operation: AccelerateBinaryOperation) -> [Double] {
    assert(left.count == right.count, "Expected arrays of the same length, instead got arrays of two different lengths")
    var results = [Double](count:left.count, repeatedValue:0.0)
    let count = UInt(left.count)
    switch operation {
    case .Add:
        vDSP_vaddD(left, 1, right, 1, &results, 1, count)
    }
    return results
}
 
println(map([4.0, 3.0, 16.0],.Sqrt))
println(zipWith([4.0, 3.0, 16.0], [4.0, 3.0, 16.0], .Add))

// Swift сам заворачивает value в Optional
func pure<A>(value: A) -> A? {
    return value
}
var s = pure(3)



