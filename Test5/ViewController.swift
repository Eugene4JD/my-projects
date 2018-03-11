//
//  ViewController.swift
//  Test5
//
//  Created by Jenia on 26.01.18.
//  Copyright © 2018 JD production. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
   private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairs)
   var numberOfPairs : Int {
        get {
            return ((cardsCollection.count + 1)/2)
        }
    }
    @IBOutlet private var cardsCollection: [UIButton]!
    @IBOutlet private weak var flipCountLable: UILabel!{
        didSet {
            updateFlipCountLable()
        }
    }
    private(set) var flipCounter = 0 {
        didSet{
            updateFlipCountLable()
        }
    }
    
    func updateFlipCountLable(){
        let atributes : [NSAttributedStringKey:Any] = [
            .strokeWidth: 5.0,
            .strokeColor: #colorLiteral(red: 1, green: 0.5841886925, blue: 0.03619439029, alpha: 1)
        ]
        let attributedString = NSAttributedString(string: "Flips : \(flipCounter)", attributes: atributes)
        flipCountLable.attributedText = attributedString
    }
    
    @IBAction private func cardTouch(_ sender: UIButton) {
        flipCounter += 1
        if let CardNuber = cardsCollection.index(of: sender){
        game.chooseCard(at: CardNuber)
        updateViewFromModel()
        } else {
            print ("this card is not in cardButtons")
        }
    }
    private func updateViewFromModel() {
        for index in cardsCollection.indices{
            let button = cardsCollection[index]
            let card = game.cards[index]
            if card.isFacedUp {
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                button.setTitle(emoji(for: card), for: UIControlState.normal)
            } else {
                button.backgroundColor = card.isMatched ?  #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : #colorLiteral(red: 1, green: 0.5841886925, blue: 0.03619439029, alpha: 1)
                button.setTitle("", for: UIControlState.normal)
            }
        }
    }
    
    //private var emojies = ["😈","👻","🎃","🙀","🦇","🍎","🍭","🍬","😱"]
    private var emojies = "😈👻🎃🙀🦇🍎🍭🍬😱"
    private var emoji = [Card:String]()
    
    private func emoji(for card : Card) -> String{
        if emoji[card] == nil, emojies.count > 0{
            let randomStringIndex = emojies.index( emojies.startIndex, offsetBy: emojies.count.arc4random)
            emoji[card] = String( emojies.remove(at: randomStringIndex))
        }
        return emoji[card] ?? "?"
    }
}
extension Int {
    var arc4random: Int {
        if self > 0 {
               return (Int(arc4random_uniform(UInt32(self))))
        } else if self < 0 {
               return(-Int(arc4random_uniform(UInt32(abs(self)))))
        } else {
               return 0
        }
    }
}



