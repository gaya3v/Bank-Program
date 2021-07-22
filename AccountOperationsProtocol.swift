//
//  AccountOperationsProtocol.swift
//  ATM Model
//
//  Created by Gayathri V on 20/07/21.
//

import Foundation

protocol AccountOperations {
    func withdraw(amount: Double, in account : Int)
    func deposit(amount: Double, in account : Int)
    func swipe(amount: Double, in account : Int)
    func isValidAmount(amount : Double) -> Bool
    func showBalance(in account : Int) 
}
