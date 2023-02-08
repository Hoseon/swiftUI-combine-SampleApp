//
//  PaymentCellView.swift
//  swiftUI-combine-SampleApp
//
//  Created by HoSeon Chu on 2023/02/08.
//

import SwiftUI

struct PaymentCellView: View {
    
    let amount: Double
    let date: Date
    
    var body: some View {
        VStack(alignment: .center, spacing: 5) {
            Text(amount.toCurrency)
                .font(.title2)
                .fontWeight(.semibold)
            
            Text(date.longDate)
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
    }
}

struct PaymentCellView_Previews: PreviewProvider {
    static var previews: some View {
        PaymentCellView(amount: 500, date: Date())
    }
}
