//
//  Date+.swift
//  AlarmCoreData
//
//  Created by James Hager on 3/31/22.
//

import Foundation

extension Date {
    
    var asFireDateString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        return dateFormatter.string(from: self)
    }
}
