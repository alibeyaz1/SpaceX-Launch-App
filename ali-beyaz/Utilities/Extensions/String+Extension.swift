//
//  String+Extension.swift
//  ali-beyaz
//
//  Created by Ali Beyaz on 29.11.2023.
//

import Foundation

extension String {
    public func returnDate(format : String = "yyyy.mm.dd") -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        if let date = dateFormatter.date(from: self) {
            return date
        } else {
            return Date()
        }
    }
}
