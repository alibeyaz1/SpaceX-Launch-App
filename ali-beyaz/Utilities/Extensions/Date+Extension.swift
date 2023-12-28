//
//  Date+Extension.swift
//  ali-beyaz
//
//  Created by Ali Beyaz on 29.11.2023.
//

import Foundation

extension Date {
    public func returnString(format : String = "yyyy-MM-dd - HH:mm") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        return dateFormatter.string(from: self)
    }
}
