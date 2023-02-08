//
//  Double+Ext.swift
//  swiftUI-combine-SampleApp
//
//  Created by HoSeon Chu on 2023/02/08.
//

import Foundation

extension Double {
    var toCurrency: String {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        
        currencyFormatter.maximumFractionDigits = 0
        currencyFormatter.numberStyle = .currency
        
        currencyFormatter.locale = Locale.current
        
        guard let priceString = currencyFormatter.string(from: NSNumber(value: self)) else {
            return ""
        }
        
        return priceString
        
    }
}
