//
//  CardGameViewController.swift
//  Assinment-1-Swift
//
//  Created by Tatiana Kornilova on 7/10/14.
//  Copyright (c) 2014 Tatiana Kornilova. All rights reserved.
//

import UIKit

class CardGameViewController: UIViewController {

    @IBOutlet var flipsLabel: UILabel?
    var flipCount: Int = 0 {
    willSet {

               self.flipsLabel!.text = "flips: " + "\(newValue)"
    }
    }

    lazy var deck: Deck = self.createDeck()
    

    func createDeck() ->Deck {
        return PlayingCardDeck()
    }

    
    @IBAction func touchCarButton(sender: UIButton) {
        
        println("Number of cards in Deck: \(self.deck.cards.count)")
        
        if (sender.currentTitle != nil) {
            sender.setBackgroundImage(UIImage(named:"cardback"), forState:.Normal)
            sender.setTitle(nil, forState:.Normal)
        } else {
            var card: Card? = self.deck.drawRandomCard()
            if card != nil {
                sender.setBackgroundImage(UIImage(named:"cardfront"), forState:.Normal)
                sender.setTitle(card!.contents, forState:.Normal)
            }
        }
        self.flipCount++;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        var pcard1:PlayingCard = PlayingCard (suit: "♠️",rank: 8)
        var pcard2:PlayingCard = PlayingCard (suit: "♥️",rank: 8)
        var pcard3:PlayingCard = PlayingCard (suit: "♥️",rank: 9)
        var pcard4:PlayingCard = PlayingCard (suit: "♦️",rank: 9)
        var pcard5:Card = Card (contents:"10♦️")
        
        var otherCards:[PlayingCard] = [pcard1,pcard2,pcard3]
        let Result = pcard1.match(otherCards)
        println("\(Result)")

    }

}
