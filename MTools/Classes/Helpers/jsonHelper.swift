
import Foundation
import SwiftyJSON

public func objToJsonString(_ params:Any) -> String {
    guard let data = objToData(_params: params) else {
        return ""
    }
    return String(data: data, encoding: .utf8 ) ?? ""
}


public class JsonChecker {



    var json:JSON?

    public var getDictionary:Dictionary<String,Any>? {
        return self.json!.dictionaryObject
    }

    public subscript(key:String) -> Any? {
        guard self.json!.dictionaryObject != nil else {
            return nil
        }
        return self.json!.dictionaryObject![key]
    }

    public init(data:Data?) {
        guard data != nil else { return }
        do {
            try self.json = try JSON(data: data!)
        } catch  {
            
        }
    }

    public init(data:String?) {
        guard data != nil else { return }
        self.json = JSON(parseJSON: data!)
    }

    public init(data:[AnyHashable : Any]) {
        self.json = JSON(data)
    }

    public func getModelByField<T:Parceble>(_ key:String? = nil) -> T? {
        guard self.json != nil else { return nil }
        if key != nil && self.json!.dictionaryObject != nil {
            guard let result = json!.dictionaryValue[key!] else { return nil }
            guard let model = result.dictionaryObject else { return nil }
            return T(json: model)
        }
        guard let result = json!.dictionaryObject else { return nil }
        return T(json: result)
    }

    public func getListModelByField<T:Parceble>(_ key:String? = nil) -> [T]? {
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

public func objToData(_ params:Any) -> Data? {
    var data:Data?
    do {
        data = try JSONSerialization.data(withJSONObject: params)
    } catch {
        return nil
    }
    return data
}


