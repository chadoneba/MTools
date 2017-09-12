//
//  DatetimeHelper.swift
//  FSMobile
//
//  Created by Aziz Said-Malik. on 01.02.17.
//  Copyright © 2017 Aziz Said-Malik. All rights reserved.
//

import Foundation


public class DateHelper {
    var formater = DateFormatter()
    var format = "dd.MM.yyyy"
    
    public init() {
        formater.dateFormat = format
    }
    
    public func toDate(str:String) -> Date? {
        guard !str.isEmpty else {
            return Date()
        }
        return self.formater.date(from: str)
    }
    
    public func toStr(date:Date) -> String {
        return self.formater.string(from: date)
    }
}
