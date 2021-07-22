//
//  main.swift
//  ATM Model
//
//  Created by Gayathri V on 19/07/21.
//

import Foundation

class BankOperation {
    var currentUser : String = ""
    var bankAccountNumber : Int = 0
    var bankAccountBalance : Double = 0.0
    var currentCardNumber : Int = 0
    var bankAccount : Account!
    var accountDetailArray : [Account] = [Account(accountNumber: [9876543210 : 1000.0, 7654321098 : 2000.0], accountHolderName: "Alex", creditCard: [CreditCard(accNumber: 9876543210, cardNumber: 1234, cvvNumber: 777, cardExpiryDate: "09/2021", pinNumber: 980), CreditCard(accNumber: 9876543210, cardNumber: 7890, cvvNumber: 121, cardExpiryDate: "11/2025", pinNumber: 534)], debitCard: [DebitCard(accNumber: 9876543210, cardNumber: 2345, cvvNumber: 111, cardExpiryDate: "03/2027", pinNumber: 233), DebitCard(accNumber: 7654321098, cardNumber: 3456, cvvNumber: 471, cardExpiryDate: "07/2024", pinNumber: 786)]), Account(accountNumber: [5678901234 : 4800.0], accountHolderName: "Bob", creditCard: [CreditCard(accNumber: 5678901234, cardNumber: 2098, cvvNumber: 076, cardExpiryDate: "08/2028", pinNumber: 555)], debitCard: [DebitCard(accNumber: 5678901234, cardNumber: 2178, cvvNumber: 142, cardExpiryDate: "07/2023", pinNumber: 707)])]
    var newAccount = Account(accountNumber: [:], accountHolderName: "", creditCard: [], debitCard: [])
    
    init() {
        getAccountNumber()
        transactionProcess()
    }
    //MARK: - get AccountNumber
    func getAccountNumber() {
        print("Enter account number to begin the process : ")
        if let accNum = readLine() {
            bankAccountNumber = (Int(accNum)) ?? 0
        }
        if doesAccountExist() {
            print("Hello", currentUser)
            bankAccountBalance = getBalance(for: bankAccountNumber)
            getCardNumber(ofAccount: bankAccountNumber)
        }
        else {
            print("Account does not exist!! \n Create new one? y / n")
            let newAccountChoice = readLine()
            if newAccountChoice == "y" {
                createAccount()
            }
            else if newAccountChoice == "n" {
                getAccountNumber()
            }
            else {
                print("Error : Enter from given options!")
            }
        }
    }
    //MARK: - does Account Exist
    func doesAccountExist() -> Bool {
        for acc in accountDetailArray {
            if acc.accountList.keys.contains(bankAccountNumber) {
                bankAccount = acc
                bankAccountBalance = acc.accountList[bankAccountNumber] ?? 0.0
                currentUser = acc.accountHolderName
                return true
            }
        }
        return false
    }
    //MARK: - get card number
    func getCardNumber(ofAccount : Int) {
        print("Enter card number to begin the process : ")
        let cardNum = readLine()
        currentCardNumber = (Int(cardNum ?? "")) ?? 0
        
        if checkCardNumber(number: currentCardNumber, of: ofAccount) == 1 {
            print("Valid credit card")
            
            if validateCreditPin(of: currentCardNumber) {
                print("Valid Pin")
            }
            else {
                print("invalid pin, try again")
                getCardNumber(ofAccount: bankAccountNumber)
            }
        }
        else if checkCardNumber(number: currentCardNumber, of: ofAccount) == 2 {
            print("Valid debit card")
            
            if validateDebitPin(of: currentCardNumber) {
                print("Valid Pin")
            }
            else {
                print("invalid pin, try again")
                getCardNumber(ofAccount: bankAccountNumber)
            }
        }
        else {
            print("Invalid card details")
            createNewCard(for: newAccount, accountNum: ofAccount)
        }
    }
    func validateCreditPin(of cardNumber : Int) ->  Bool {
        print("Enter PIN number : ")
        let pinNumber = readLine() ?? ""
        for acc in accountDetailArray {
            for card in acc.creditCard {
                if card.cardNumber == cardNumber {
                    if card.pinNumber == Int(pinNumber) {
                        return true
                    }
                }
                
            }
        }
       return false
    }
    func validateDebitPin(of cardNumber : Int) ->  Bool {
        print("Enter PIN number : ")
        let pinNumber = readLine() ?? ""
        for acc in accountDetailArray {
            for card in acc.debitCard {
                if card.cardNumber == cardNumber {
                    if card.pinNumber == Int(pinNumber) {
                        return true
                    }
                }
                
            }
        }
       return false
    }
    //MARK: - create Account
    func createAccount() {
        
        bankAccount = newAccount
        
        print("Enter new account number : ")
        let accountNumber = readLine()
        //newAccount.accountNumber.keys.append(Int(accountNumber ?? "") ?? 0)
        
        print("Enter new account holder's name : ")
        let accountHolderName = readLine()
        newAccount.accountHolderName = accountHolderName ?? ""
        
        print("Enter new account balance : ")
        let accountBalance = readLine()
       // newAccount.balance = Double(accountBalance ?? "") ?? 0.0
        newAccount.accountList[Int(accountNumber ?? "") ?? 0] = Double(accountBalance ?? "") ?? 0.0
        accountDetailArray.append(newAccount)
    }
    //MARK: - create new Card
    func createNewCard(for newAccount : Account, accountNum : Int) {
        print("Do you want new debit / credit card ? y / n \n")
        let n = readLine()
        if n == "y" {
            
            print("Enter 1 for new credit card \n Enter 2 for new debit card ")
            
            let cardChoice = readLine()
            if cardChoice == "1" {
                createCreditCard(for: newAccount, accountNum: accountNum)
            }
            else if cardChoice == "2" {
                createDebitCard(for: newAccount, accountNum: accountNum)
            }
        }
        else if n == "n" {
            getCardNumber(ofAccount: accountNum)
        }
        else {
            print("Inappropriate choice")
            createNewCard(for: newAccount, accountNum: accountNum)
        }
    }
    //MARK: - createCreditCard
    func createCreditCard(for newAccount : Account, accountNum : Int) {
        print("Enter new credit card number : ")
        let cvvNum = readLine()
        print("Enter the CVV number of new credit card : ")
        let ccNumber = readLine()
        print("Enter the expiry date of new credit card : ")
        let expiryDate = readLine()
        print("Set new pin number : ")
        let pin = readLine()
        
        newAccount.creditCard.append(CreditCard(accNumber: accountNum, cardNumber: Int(ccNumber ?? "") ?? 0, cvvNumber: Int(cvvNum ?? "") ?? 0, cardExpiryDate: expiryDate ?? "", pinNumber: Int(pin ?? "") ?? 0))
    }
    //MARK: - createDebitCard
    func createDebitCard(for newAccount : Account, accountNum : Int) {
        print("Enter new debit card number : ")
        let cvvNum = readLine()
        print("Enter the CVV number of new debit card : ")
        let ccNumber = readLine()
        print("Enter the expiry date of new debit card : ")
        let expiryDate = readLine()
        print("Set new pin number : ")
        let pin = readLine()
        
        newAccount.debitCard.append(DebitCard(accNumber: accountNum, cardNumber: Int(ccNumber ?? "") ?? 0, cvvNumber: Int(cvvNum ?? "") ?? 0, cardExpiryDate: expiryDate ?? "", pinNumber: Int(pin ?? "") ?? 0))
    }
    //MARK: - check CardNumber
    func checkCardNumber(number : Int, of account : Int) -> Int {
        for acc in accountDetailArray {
            for card in acc.creditCard {
                if card.cardNumber == number && card.accNumber == account {
                    return 1
                }
            }
            for card in acc.debitCard {
                if card.cardNumber == number && card.accNumber == account {
                    return 2
                }
            }
            
        }
        return -1
    }
    //MARK: - get balance
    func getBalance(for accountNum : Int) -> Double {
        if !doesAccountExist() {
            print("Enter initial balance for transactions : ")
            if let bal = readLine() {
                bankAccountBalance = Double(bal) ?? 0.0
                newAccount.accountList[accountNum] = bankAccountBalance
            }
        }
        
        print("Balance is - ", bankAccountBalance)
        
        return bankAccountBalance
    }

    func transactionProcess() {
        
        while (true) {
            //MARK: - check for min balance of $100
            if (bankAccount.hasMinimumBalance(amount: bankAccountBalance,in: bankAccountNumber)) {
                print("Please enter a choice - \n 1. Withdraw \n 2. Deposit \n 3. Swipe \n 4. Show \n 5. Summary of Accounts \n 6. Quit")
                let str = readLine()
                let choice = Int(str ?? "-1")
                switch(choice) {
                case 1 :
                    print("Enter amount : ")
                    let amount = readLine()
                    bankAccount.withdraw(amount: (Double(amount!)) ?? 0.0, in: bankAccountNumber)
                case 2 :
                    print("Enter amount : ")
                    let amount = readLine()
                    bankAccount.deposit(amount: (Double(amount!)) ?? 0.0, in: bankAccountNumber)
                case 3 :
                    print("Enter amount : ")
                    let amount = readLine()
                    bankAccount.swipe(amount: (Double(amount!)) ?? 0.0, in: bankAccountNumber)
                case 4 :
                    bankAccount.showBalance(in: bankAccountNumber)
                case 5:
                    print("Summary of all accounts : \n")
                    for account in accountDetailArray {
                        for (key,value) in account.accountList {
                            print("Account number : \(key) \t Balance : \(value)")
                            
                        }
                    }
                    
                case 6 :
                    print("Thank you for banking with us!")
                    exit(0)
                     
                default:
                    print("Enter correct choice !!")
                    
                }
            }
            else {
                print("Bank account has balance below 100, cannot do transactions. Bye !")
                break
            }
            
        }
        
    }
}
//driver code
print("Enter the ATM Branch : ")
let atmBranch = readLine()
let atm = ATM(id: 1, atmLocation: atmBranch ?? "")
print("Welcome to \(atm.atmLocation) branch ATM of HDFC Bank \n")
let bank = BankOperation()
