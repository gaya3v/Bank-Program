//
//  CreditCard.swift
//  ATM Model
//
//  Created by Gayathri V on 20/07/21.
//

import Foundation

class CreditCard : CardProtocol {
    var accNumber : Int
    private (set) var cardNumber : Int
    private (set) var cvvNumber : Int
    private (set) var cardExpiryDate : String
    private (set) var pinNumber : Int
    init(accNumber : Int, cardNumber : Int, cvvNumber : Int, cardExpiryDate : String, pinNumber : Int) {
        self.accNumber = accNumber
        self.cardNumber = cardNumber
        self.cvvNumber = cvvNumber
        self.cardExpiryDate = cardExpiryDate
        self.pinNumber = pinNumber
    }
}
