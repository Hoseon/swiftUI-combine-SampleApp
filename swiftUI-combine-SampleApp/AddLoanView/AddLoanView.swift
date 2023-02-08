//
//  AddLoanView.swift
//  swiftUI-combine-SampleApp
//
//  Created by HoSeon Chu on 2023/02/08.
//

import SwiftUI

struct AddLoanView: View {
    // MARK: - PROPERTIES
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: AddLoanViewModel
    
    // MARK: - BODY
    
    var body: some View {
        VStack {
            
            HStack {
                Button(action: {
//                    self.presentationMode.wrappedValue.dismiss()
                    viewModel.isAddLoanShowing.wrappedValue = false
                }) {
                    Text("Cancel")
                        .font(.title3)
                        .frame(width: 80, height: 30)
                }
                
                Spacer()
                
                Button(action: {
                    viewModel.saveLoan()
                    viewModel.isAddLoanShowing.wrappedValue = false
                }) {
                    Text("Done")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .frame(width: 70, height: 30)
                }
                .disabled(viewModel.isVaildForm())
            }//: HSTACK
            .padding()
            
            
            Form {
                TextField("Name", text: $viewModel.name)
                    .textInputAutocapitalization(.sentences)
                TextField("Amount", text: $viewModel.amount)
                    .keyboardType(.numberPad)
                DatePicker(
                    "Start Date",
                    selection: $viewModel.startDate,
                    displayedComponents: .date
                )
                DatePicker(
                    "Due Date",
                    selection: $viewModel.dueDate,
                    displayedComponents: .date
                )
                
            }
            
            
        }//: VSTACK
    }
}

//struct AddLoanView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddLoanView()
//    }
//}
