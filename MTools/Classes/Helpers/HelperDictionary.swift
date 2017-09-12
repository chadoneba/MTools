//
//  HelperDictionary.swift
//  FSMobile
//
//  Created by Aziz Said-Malikv on 18.12.16.
//  Copyright © 2016 Aziz Said-Malik. All rights reserved.
//

import Foundation

// Расширение для Типа словарей

public extension Dictionary {
   
    // Знак
    public static func += (left:inout [Key:Value],right:[Key:Value]){
        for obj in right {
            left.updateValue(obj.value, forKey: obj.key)
        }
    }
    
    // Сумирование словарей
    public static func + (left:[Key:Value],right:[Key:Value])->[Key:Value]{
        var result = left
        for obj in right {
            result.updateValue(obj.value, forKey: obj.key)
        }
        return result
    }
    
    // Замена ключа с сохранением связанного значения
    public mutating func updateKey(from:Key,to:Key){
        guard self.index(forKey: from) != nil else {
            return
        }
        let tmp = self.remove(at: self.index(forKey: from)!)
        self.updateValue(tmp.value, forKey: to)
    }
    
    public func filterAsDict(_ isIncluded: (Key,Value?) -> Bool) -> [Key:Value?] {
        var result = [Key:Value]()
        for (Key,Value) in self {
            if isIncluded(Key,Value) {
               result.updateValue(Value, forKey: Key)
            }
        }
        return result
    }

}




public func groupArrayByKey<T>(array:[T],key:@escaping (T) -> String) -> Dictionary<String,Array<T>> {
    var result:Dictionary<String,Array<T>> = [:]
    for item in array {
        var value = result[key(item)]
        if value == nil {
            value = [item]
        } else {
            value!.append(item)
        }
        result.updateValue(value!, forKey: key(item))

    }
    return result
}

public func groupObjectByKey<T>(array:[T],key:@escaping (T) -> String) -> Dictionary<String,T> {
    var result:Dictionary<String,T> = [:]
    for item in array {
        result.updateValue(item, forKey: key(item))

    }
    return result
}

