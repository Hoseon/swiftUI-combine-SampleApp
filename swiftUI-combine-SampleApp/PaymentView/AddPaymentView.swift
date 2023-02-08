//
//  AddPaymentView.swift
//  swiftUI-combine-SampleApp
//
//  Created by HoSeon Chu on 2023/02/08.
//

import SwiftUI

struct AddPaymentView: View {
        
    @ObservedObject var viewModel: AddPaymentViewModel
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    var body: some View {
        Form {
            Section {
                TextField("Amout", text: $viewModel.amount)
                    .keyboardType(.numberPad)
                
                DatePicker("Date", selection: $viewModel.date, displayedComponents: .date)
            }
            
            Section {
                Button {
                    viewModel.savePayment()
                    self.mode.wrappedValue.dismiss()
                    
                } label: {
                    Text("Save")
                        .font(.title2)
                        .fontWeight(.semibold)
                }
                .disabled(viewModel.isFormValid())
            }
            .onAppear() {
                viewModel.setupEditingView()
            }
        }
        .navigationTitle(viewModel.payment != nil ? "Edit Payment" : "Add Payment")
    }
}
