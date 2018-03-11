//
//  Card.swift
//  Test5
//
//  Created by Jenia on 30.01.18.
//  Copyright © 2018 JD production. All rights reserved.
//

import Foundation
struct Card: Hashable
{
    var hashValue: Int { return identifier }
    
    static func ==(lhs: Card, rhs: Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    var isFacedUp = false
    var isMatched = false
    private var identifier: Int
    
    private static var identifierFactory = 0
    
    private static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    init() {
     self.identifier = Card.getUniqueIdentifier()
    }
}

