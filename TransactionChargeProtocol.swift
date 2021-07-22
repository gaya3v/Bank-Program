//
//  TransactionChargeProtocol.swift
//  ATM Model
//
//  Created by Gayathri V on 20/07/21.
//

import Foundation
protocol TransactionCharge {
    func cashback(amount : Double) -> Double
    func taxCharges(amount : Double) -> Double
}
