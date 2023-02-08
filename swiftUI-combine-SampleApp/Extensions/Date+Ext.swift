//
//  Date+Ext.swift
//  swiftUI-combine-SampleApp
//
//  Created by HoSeon Chu on 2023/02/08.
//

import Foundation

extension Date {
    var dayNumberOfYear: Int? {
        return Calendar.current.dateComponents([.year], from: self).year
    }
    
    var longDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MM yyyy"
        return dateFormatter.string(from: self)
    }
}
