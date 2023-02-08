//
//  PaymentView.swift
//  swiftUI-combine-SampleApp
//
//  Created by HoSeon Chu on 2023/02/08.
//

import SwiftUI

struct PaymentView: View {
    @ObservedObject var viewModel: PaymentViewModel
    
    var body: some View {
        VStack {
            Text("Payment Progress")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .padding(.top)
            
            ProgressBar(value: viewModel.progressValue(), leftAmount: viewModel.totalLeft(), paidAmount: viewModel.totalPaid())
                .frame(height: 30)
                .padding(.horizontal)
            
            Text(viewModel.expectedToFinishOn)
            
            List {
                ForEach(viewModel.allPaymentObjects, id: \.sectionName) { paymentObject in
                    Section(header: Text("\(paymentObject.sectionName)-\(paymentObject.sectionTotal.toCurrency)")) {
                        ForEach(paymentObject.sectionObjects) { payment in
                            PaymentCellView(amount: payment.amout, date: payment.date ?? Date())
                                .onTapGesture {
                                    viewModel.isNavigationLinkActive = true
                                    viewModel.selectedPayment = payment
                                }
                        }
                        .onDelete { index in
                            viewModel.delete(paymentObject: paymentObject, index: index)
                        }
                    }
                }
            }
            .listStyle(PlainListStyle())
        }
        .navigationTitle(viewModel.loan.name ?? "Loan")
        .navigationBarItems(trailing: Button(action: {
            viewModel.isNavigationLinkActive = true
        }, label: {
            Image(systemName: "plus")
                .font(.title)
        })
            .background(
                NavigationLink(destination: AddPaymentView(viewModel: AddPaymentViewModel(paymentToEdit: viewModel.selectedPayment, loanId: viewModel.loan.id ?? "")), isActive: $viewModel.isNavigationLinkActive) {
                    EmptyView()
                }
                    .hidden()
            )
                .onAppear(perform: {
                    viewModel.fetchAllPayment()
                    viewModel.calculateDays()
                    viewModel.separateByYear()
                })
        )
    }
}
