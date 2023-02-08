//
//  AddLoanViewModel.swift
//  swiftUI-combine-SampleApp
//
//  Created by HoSeon Chu on 2023/02/08.
//

import SwiftUI

class AddLoanViewModel: ObservableObject {
    @Published var name:String = ""
    @Published var amount:String = ""
    @Published var startDate:Date = Date()
    @Published var dueDate:Date = Date()
    var isAddLoanShowing: Binding<Bool>
    
    init(isAddLoanShowing: Binding<Bool>) {
        self.isAddLoanShowing = isAddLoanShowing
    }
    
    func saveLoan() {
        let newLoan = Fuck(context: PersistenceController.shared.viewContext)
        newLoan.id = UUID().uuidString
        newLoan.name = self.name
        newLoan.totalAmout = Double(self.amount) ?? 0.0
        newLoan.startDate = self.startDate
        newLoan.dueDate = self.dueDate
        
        PersistenceController.shared.save()
    }
    
    func isVaildForm() -> Bool {
        return self.name.isEmpty || self.amount.isEmpty
    }
}
