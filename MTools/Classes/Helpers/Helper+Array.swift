//
//  Helper+Array.swift
//  FSMobile
//
//  Created by Aziz Said-Malik on 04.01.17.
//  Copyright © 2017 Aziz Said-Malik. All rights reserved.
//

import Foundation


public extension Array {
    public func sum(handler:(Element) -> Int) -> Int {
        var tmp = 0
        for item in self {
           tmp += handler(item)
        }
        return tmp
    }
}

