//
// Created by Mikhail Maltsev on 06.06.17.
// Copyright (c) 2017 Aziz Said-Malik. All rights reserved.
//

import Foundation
import SwiftyJSON

func objToJsonString(_ params:Any) -> String {
    guard let data = objToData(_params: params) else {
        return ""
    }
    return String(data: data, encoding: .utf8 ) ?? ""
}


class JsonChecker {



    var json:JSON?

    var getDictionary:Dictionary<String,Any>? {
        return self.json!.dictionaryObject
    }

    subscript(key:String) -> Any? {
        guard self.json!.dictionaryObject != nil else {
            return nil
        }
        return self.json!.dictionaryObject![key]
    }

    init(data:Data?) {
        guard data != nil else { return }
        self.json = JSON(data: data!)
    }

    init(data:String?) {
        guard data != nil else { return }
        self.json = JSON(parseJSON: data!)
    }

    init(data:[AnyHashable : Any]) {
        self.json = JSON(data)
    }

    func getModelByField<T:Parceble>(_ key:String? = nil) -> T? {
        guard self.json != nil else { return nil }
        if key != nil && self.json!.dictionaryObject != nil {
            guard let result = json!.dictionaryValue[key!] else { return nil }
            guard let model = result.dictionaryObject else { return nil }
            return T(json: model)
        }
        guard let result = json!.dictionaryObject else { return nil }
        return T(json: result)
    }

    func getListModelByField<T:Parceble>(_ key:String? = nil) -> [T]? {
        guard self.json != nil else { return nil }
        if key != nil && self.json!.dictionaryObject != nil {
            guard let result = json!.dictionaryValue[key!] else { return nil }
            guard let list = result.arrayObject else { return nil }
            return list.map { T(json: $0 as! [String:Any]) }
        }
        guard let list = json!.arrayObject else { return nil }
        return list.map { T(json: $0 as! [String:Any]) }
    }
}

func objToData(_ params:Any) -> Data? {
    var data:Data?
    do {
        data = try JSONSerialization.data(withJSONObject: params)
    } catch {
        return nil
    }
    return data
}


