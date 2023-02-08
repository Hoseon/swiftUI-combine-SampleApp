//
//  AddPaymentViewModel.swift
//  swiftUI-combine-SampleApp
//
//  Created by HoSeon Chu on 2023/02/08.
//

import Foundation
import SwiftUI

final class AddPaymentViewModel: ObservableObject {
    @Published var amount = ""
    @Published var date = Date()
    @Published var payment: Payment?
    
    var loanId: String
    
    init(paymentToEdit payment: Payment?, loanId: String) {
        self.payment = payment
        self.loanId = loanId
    }
    
    func savePayment() {
        if payment != nil {
            updatePayment()
        } else {
            createNewPayment()
        }
    }
    
    func createNewPayment() {
        let newPayment = Payment(context: PersistenceController.shared.viewContext)
        newPayment.id = UUID().uuidString
        newPayment.amout = Double(amount) ?? 0.0
        newPayment.date = date
        newPayment.loanId = loanId
        
        PersistenceController.shared.save()
    }
    
    func updatePayment() {
        payment!.amout = Double(amount) ?? 0.0
        payment!.date = date
        
        PersistenceController.shared.save()
    }
    
    func setupEditingView() {
        if payment != nil {
            self.amount = "\(payment!.amout)"
            self.date = payment!.date ?? Date()
        }
    }
    
    func isFormValid() -> Bool {
        return self.amount.isEmpty
    }
}
