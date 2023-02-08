//
//  ContentView.swift
//  swiftUI-combine-SampleApp
//
//  Created by HoSeon Chu on 2023/02/08.
//

import SwiftUI
import CoreData

struct LoanView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Fuck.startDate, ascending: true)],
        animation: .default)
    private var loans: FetchedResults<Fuck>
    
    @State var isAddLoanShowing = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(loans) { loan in
                    NavigationLink(destination: PaymentView(viewModel: PaymentViewModel(loan: loan))) {
                        LoanCellView(name: loan.name ?? "Unknown", amount: loan.totalAmout, date: loan.dueDate ?? Date())
                    }
                    
                    
                }
                .onDelete(perform: deleteItems)
            }
            .listStyle(PlainListStyle())
            .navigationTitle("SwiftUI+Combine")
            .navigationBarItems(trailing: Button(action: {
//                addItem()
                self.isAddLoanShowing = true
            }, label: {
                Image(systemName: "plus")
                    .font(.title)
            }))
            .tint(Color(.label))
            .sheet(isPresented: $isAddLoanShowing) {
                AddLoanView(viewModel: AddLoanViewModel(isAddLoanShowing: $isAddLoanShowing))
            }
            
        }
    }
    
    private func addItem() {
        withAnimation {
            let newLoan = Fuck(context: viewContext)
            newLoan.name = "Test Loan"
            newLoan.totalAmout = 100000
            newLoan.startDate = Date()
            newLoan.dueDate = Date()
            
            do {
                try viewContext.save()
            } catch {
                print("세이브 하지 못했음 : \(error.localizedDescription)")
            }
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { loans[$0] }.forEach(viewContext.delete)
            
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved   \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoanView()
    }
}
