//
//  LoanCellView.swift
//  swiftUI-combine-SampleApp
//
//  Created by HoSeon Chu on 2023/02/08.
//

import SwiftUI

struct LoanCellView: View {
    let name: String
    let amount: Double
    let date: Date
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 5) {
                Text(name)
                    .font(.title2)
                    .fontWeight(.semibold)
                
                Text(amount.toCurrency)
                    .font(.title2)
                    .fontWeight(.light)
            }
            
            Spacer()
            
            Text(date.longDate)
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
    }
}

struct LoanCellView_Previews: PreviewProvider {
    static var previews: some View {
        LoanCellView(name: "Test name", amount: 1000, date: Date())
            .previewLayout(.fixed(width: 375, height: 80))
    }
}
