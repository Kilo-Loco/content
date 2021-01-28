//
//  DateService.swift
//  not-github
//
//  Created by Kilo Loco on 1/27/21.
//

import Foundation

class DateService {
    private init() {}
    static let shared = DateService()
    
    var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
}
