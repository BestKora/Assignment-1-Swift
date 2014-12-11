//
//  PlayingCard.swift
//  MatchismoSwift
//
//  Created by Tatiana Kornilova on 6/9/14.
//  Copyright (c) 2014 Tatiana Kornilova. All rights reserved.
//

import Foundation
func == (v1:Card, v2:Card) -> Bool {
    return v1.contents.isEqual(v2.contents)
}
extension Card : Equatable {}


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
/*
    override func match(otherCards: [Card]) -> Int {
        var score = 0
        var numMatches = 0
        var numCards = otherCards.count
        
        if numCards > 0
        {
            for  i in 0..<numCards{
                var card1:PlayingCard? = otherCards[i] as? PlayingCard
                if card1
                {
                    for  j in i+1..<numCards {
                        var card2:PlayingCard? = otherCards[j] as? PlayingCard
                        if card2
                        {
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
*/
//---------------------
        override func match(otherCards: [Card]) -> Int {
            var aM = AccumulatorMatches()
            let a2 = otherCards.map({$0 as PlayingCard}).pairs().map(aM.add)
            println(" aaa2 \(a2)")
            
            let score = aM.result.sum>=(otherCards.count-1) ?(aM.result.sumRank + 4 * aM.result.sumSuit) :0
            println("RESULT: \(aM.result.sumRank) \(aM.result.sumSuit) \(score)")
            return score
            
    }
//---------------------
    
}
class AccumulatorMatches {
    var result:(sumRank: Int,sumSuit: Int, sum: Int) = (sumRank: 0,sumSuit: 0, sum: 0)
    func add(pair:( PlayingCard, PlayingCard)) -> ( PlayingCard, PlayingCard){
        switch (pair.0.suit, pair.0.rank,  pair.1.suit,  pair.1.rank){
        case let (suit1, _, suit2,_) where suit1 == suit2:
            result.sumSuit += 1
            result.sum += 1
            return pair
        case let (_, rank1, _, rank2) where rank1 == rank2:
            result.sumRank += 1
            result.sum += 1
            return pair
        default:
            return pair
        }
    }
}
extension Array {
    //------- function pais ------
    func pairs() -> [(T,T)]{
        var pairsTuple : [(T,T)] = [(T,T)]()
        var dr = dropFirst(self)
        while !dr.isEmpty {
            let dop = Zip2(self, dr)
            pairsTuple += dop
            dr = dropFirst(dr)
        }
        return pairsTuple
    }
    //------- function fPairs ------
    func fPairs(  s1 : [T], acc: [(T,T)] = [(T,T)]()) -> [(T,T)] {
        if s1.isEmpty {
            return acc
        }
        else {
            let dr = dropFirst(s1)
            return fPairs(Array(dr),acc: acc+Zip2(self, dr))
        }
    }
    
}

