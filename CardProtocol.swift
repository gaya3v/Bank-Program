//
//  CardProtocol.swift
//  ATM Model
//
//  Created by Gayathri V on 20/07/21.
//

import Foundation

protocol CardProtocol {
    var cardNumber : Int { get }
    var cvvNumber : Int { get }
    var cardExpiryDate : String { get }
    var pinNumber : Int { get }
}
