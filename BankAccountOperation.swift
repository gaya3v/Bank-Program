//
//  Transaction.swift
//  ATM Model
//
//  Created by Gayathri V on 20/07/21.
//

import Foundation
class Account : AccountOperations, TransactionCharge, BalanceChecker {
    var accountList : [Int : Double]
    var accountHolderName : String
    var creditCard : [CreditCard]
    var debitCard : [DebitCard]
    
    init (accountNumber : [Int : Double], accountHolderName : String, creditCard : [CreditCard], debitCard : [DebitCard]) {
        self.accountList = accountNumber
        self.accountHolderName = accountHolderName
        self.creditCard = creditCard
        self.debitCard = debitCard
    }
    func hasMinimumBalance(amount : Double, in account : Int) -> Bool {
      //  guard let balance = accountList[account] else { return false }
        if (accountList[account] ?? 0.0)<100 {
            return false
        }
        return true
    }
    
    func hasSufficientBalanceForTransaction(amount: Double, in account : Int) -> Bool {
     //   guard let balance = accountList[account] else { return false }
        if amount > (accountList[account] ?? 0.0) {
            return false
        }
        return true
    }
    
    func cashback(amount: Double) -> Double {
        let bonus = amount * 0.01
        print("Cashback on Swiping - USD $",bonus)
        return bonus
    }
    
    func taxCharges(amount: Double) -> Double {
        if amount > 100 {
            let reductionAmt = amount * 0.04
            print("Transaction Charges - USD $",reductionAmt)
            return reductionAmt
        }
        else {
            let reductionAmt = amount * 0.02
            print("Transaction Charges - USD $",reductionAmt)
            return reductionAmt
        }
    }
    
    func withdraw(amount: Double, in account : Int) {
      //  var balance = accountList[account] ?? 0.0
        if hasSufficientBalanceForTransaction(amount: amount, in: account) {
            if isValidAmount(amount: amount) {
                print("Withdraw amount - USD $",amount)
                accountList[account]! -= amount
                let charges = taxCharges(amount: amount)
                accountList[account]! -= charges
                print("Balance in account after withdrawal is USD $",accountList[account] ?? 0.0)
            }
            else {
                print("Enter amount in terms of USD $5")
            }
        }
        else {
            print("Insufficient funds for transaction")
        }
    }
    
    func deposit(amount: Double, in account : Int) {
      //  var balance = accountList[account] ?? 0.0
        print("Deposit amount - USD ",amount)
        accountList[account]! += amount
        print("Balance in account after deposit is USD $",accountList[account] ?? 0.0)
    }
    
    func swipe(amount: Double, in account : Int) {
        //var balance = accountList[account] ?? 0.0
        if hasSufficientBalanceForTransaction(amount: amount, in: account) {
            if isValidAmount(amount: amount) {
                print("Swipe amount - USD $",amount)
                accountList[account]! -= amount
                let bonus = cashback(amount: amount)
                accountList[account]!+=bonus
                print("Balance in account after cashback is USD $",accountList[account] ?? 0.0)
            }
            else {
                print("Enter amount in terms of USD $5")
            }
        }
        else {
            print("Insufficient funds for transaction")
        }
    }
    
    func showBalance(in account : Int) {
       // var balance = accountList[account] ?? 0.0
        print("BALANCE : USD $",accountList[account] ?? 0.0)
    }
    
    func isValidAmount(amount: Double) -> Bool {
        if amount.truncatingRemainder(dividingBy: 5.0) == 0 {
            return true
        }
        return false
    }
    
}


