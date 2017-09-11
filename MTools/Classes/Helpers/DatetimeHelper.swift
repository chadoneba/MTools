//
//  DatetimeHelper.swift
//  FSMobile
//
//  Created by Aziz Said-Malik. on 01.02.17.
//  Copyright © 2017 Aziz Said-Malik. All rights reserved.
//

import Foundation


class DateHelper {
    var formater = DateFormatter()
    var format = "dd.MM.yyyy"
    
    init() {
        formater.dateFormat = format
    }
    
    func toDate(str:String) -> Date? {
        guard !str.isEmpty else {
            return Date()
        }
        return self.formater.date(from: str)
    }
    
    func toStr(date:Date) -> String {
        return self.formater.string(from: date)
    }
}
