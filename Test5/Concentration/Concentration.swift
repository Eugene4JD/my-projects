//
//  Concentration.swift
//  Test5
//
//  Created by Jenia on 30.01.18.
//  Copyright © 2018 JD production. All rights reserved.
//

import Foundation

struct Concentration
{
    private(set) var cards = [Card]()
    private var indexOfOneAndOnlyFaceUpCard: Int?{
        get {
            return cards.indices.filter{cards[$0].isFacedUp}.isOneAndOnly
//            var foundIndex: Int?
//            for index in cards.indices{
//                if cards[index].isFacedUp{
//                    if foundIndex == nil{
//                        foundIndex = index
//                    } else {
//                        return nil
//                    }
//                }
//            }
//            return foundIndex
            }
       set{
            for index in cards.indices{
            cards[index].isFacedUp = (index == newValue)
            }
        }
    }
    
    mutating func chooseCard (at index: Int){
        assert (cards.indices.contains(index), "Concentration.choseCard (at:\(index): index is not in the cards")
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index{
                if cards[matchIndex] == cards[index]{
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFacedUp = true
            } else {
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    init (numberOfPairsOfCards: Int){
        assert (numberOfPairsOfCards > 0, "Concentration.init(\(numberOfPairsOfCards): you must have at least one pair of cards")
        for _  in 1...numberOfPairsOfCards {
        let card = Card()
        cards += [card,card]
        }
        cards = shuffle(with: cards)
    }
        func shuffle (with deck:[Card] ) -> [Card]{
        var DeckToShuffle = deck
        var shuffleDeck = [Card]()
        for _ in 1...deck.count{
            shuffleDeck.append(DeckToShuffle.remove(at: DeckToShuffle.count.arc4random))
            
        }
        return shuffleDeck
    }
    
}
extension Collection{
    var isOneAndOnly : Element?{
        return count == 1 ? first : nil
        
    }
}

