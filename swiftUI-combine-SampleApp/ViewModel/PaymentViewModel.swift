//
//  PaymentViewModel.swift
//  swiftUI-combine-SampleApp
//
//  Created by HoSeon Chu on 2023/02/08.
//

import SwiftUI

final class PaymentViewModel: ObservableObject {
    
    @Published var allPayments:[Payment] = []
    @Published var allPaymentObjects:[PaymentObject] = []
    @Published var isNavigationLinkActive = false
    @Published var expectedToFinishOn = ""
    @Published var selectedPayment: Payment?
    
    var loan: Fuck
    
    init(loan: Fuck) {
        self.loan = loan
    }
    
    func totalPaid() -> Double {
        return allPayments.reduce(0) {
            $0 + $1.amout
        }
    }
    
    func totalLeft() -> Double {
        return self.loan.totalAmout - totalPaid()
    }
    
    func progressValue() -> Double {
        return totalPaid() / self.loan.totalAmout
    }
    
    func fetchAllPayment() {
        guard let loadId = loan.id else {
            return
        }
        allPayments = PersistenceController.shared.fetchPayments(for: loadId)
    }
    
    func delete(paymentObject: PaymentObject, index: IndexSet) {
        
        guard let indexRow = index.first else { return }
        
        let paymentToDelete = paymentObject.sectionObjects[indexRow]
        PersistenceController.shared.viewContext.delete(paymentToDelete)
        PersistenceController.shared.save()
        
        fetchAllPayment()
        calculateDays()
        separateByYear()

    }
    
    func calculateDays() {
        let totalPaid = totalPaid()
        
        let totalDay = Calendar.current.dateComponents([.day], from: loan.startDate ?? Date(), to: loan.dueDate ?? Date()).day!
        
        let passedDays = Calendar.current.dateComponents([.day], from: loan.startDate ?? Date(), to: loan.dueDate ?? Date()).day!
        
        if passedDays == 0 || totalPaid == 0 {
            expectedToFinishOn = ""
            return
        }
        
        let didPayPerDay = totalPaid / Double(passedDays)
        
        let daysLeftToFinish = (loan.totalAmout - totalPaid) / didPayPerDay
        
        let newDate = Calendar.current.date(byAdding: .day, value: Int(daysLeftToFinish), to: Date())
        
        guard let newDate = newDate else {
            expectedToFinishOn = ""
            return
        }
        
        expectedToFinishOn = "Expected to finish by \(newDate.longDate)"
    }
    
    func separateByYear() {
        allPaymentObjects = []
        
        let dict = Dictionary(grouping: allPayments, by: { $0.date?.dayNumberOfYear })
        
        for (key, value) in dict {
            
            var total = 0.0
            
            for payment in value {
                total += payment.amout
            }
            
            allPaymentObjects.append(PaymentObject(sectionName: "\(key!)", sectionObjects: value, sectionTotal: total))
        }
        
        allPaymentObjects.sorted(by: { $0.sectionName > $1.sectionName })
    }
}

struct PaymentObject: Equatable {
    var sectionName: String!
    var sectionObjects: [Payment]!
    var sectionTotal: Double!
}
