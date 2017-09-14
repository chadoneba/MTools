//
//  PureManager.swift
//  FSMobile
//
//  Created by Aziz Said-Malik on 06.12.16.
//  Copyright © 2016 Aziz Said-Malik. All rights reserved.
//

import Foundation
import SwiftyJSON

let DEBUGLOCAL = "debugLocal"

public protocol Parceble {
    init(json:[String:Any]!)
}

public protocol sessionNotification {
    func invalidate()
}

public extension Parceble {
    
    // Вывод свойств классов протокола Parceble в словарь с фильтрацией по словарю ключей
    
    public func toJson(_ template:[String] = [])->[String:String] {
        guard template.count > 0 else {
            return [:]
        }
        var return_dict = [String:String]()
        let main_mirror = Mirror.init(reflecting: self)
        return_dict += self.getDictBy(mirror: main_mirror, template: template)
        if let super_mirror = main_mirror.superclassMirror {
            return_dict += self.getDictBy(mirror: super_mirror, template: template)
        }
        return return_dict
    }

    
    
    
    // Собственно функция фильтрации
    
    public func getDictBy(mirror:Mirror,template:[String])->[String:String] {
        var return_dict = [String:String]()
        
        var doesApplyAll = false
        
        if template[0] == "*" {
            doesApplyAll = true
        }
        
        for obj in mirror.children {
            
            if template.contains(obj.label!) || doesApplyAll {
                if ((obj.value as? String) != nil) {
                    return_dict.updateValue(obj.value as! String, forKey: obj.label!)
                }
                
            }
        }
        return return_dict
    }

    public func getNotParcedParams(byname:String = "") -> [String:Any] {
        return [:]
    }
    
    
}

// Основной класс работы с сетью

public class PureManager:NSObject,URLSessionDelegate {
    var session:URLSession!
    var session_delegate:URLSessionDelegate?
    var host:String!
    var delegate:sessionNotification?
    let debugServerAdr = "http://192.168.1.72:8002"

    
    public func logout() {
        self.session.invalidateAndCancel()
    }
    
    public func urlSession(_ session: URLSession, didBecomeInvalidWithError error: Error?) {
        self.session = nil
        self.delegate?.invalidate()
    }
    
    
    
    static let instance:PureManager = PureManager()
    
    
    public static var TheInstance : PureManager {
        get { return instance }
    }
    
    
    public override init()
    {
        super.init()
        self.getSession()
    }
    
    public func getSession() {
        self.session = URLSession(configuration: self.getConfiguration(), delegate: self, delegateQueue: nil)
    }
    
    public func getConfiguration()->URLSessionConfiguration
    {
        let configuration1 = URLSessionConfiguration.default
        configuration1.allowsCellularAccess = true
        configuration1.httpShouldSetCookies = true
        configuration1.httpCookieStorage = HTTPCookieStorage.shared
        return configuration1
    }
    
    public func decorate<T, U>(_ function: @escaping (T) -> U, decoration: @escaping (T, U) -> U) -> (T) -> U {
        return { args in
            decoration(args, function(args))
        }
    }
    
    // Основной метод запроса
    // path - дополнительная часть url
    // params - строковый словарь параметров
    // handler - колбек
    
    public func connect(path:String,params:[String:Any],image:UIImage?,handler:@escaping (Data?,URLResponse?,Error?)-> Void) {
        guard self.host != nil else {
            self.delegate!.invalidate()
            return
        }
        if session == nil {
            self.getSession()
        }
        
        guard host != nil else {
            return
        }



        let reqMan = RequestManager(host: path == DEBUGLOCAL ? debugServerAdr : host + path)
        if image != nil {
            reqMan.getImageRequest(params: params as! [String:String], image: image!)
        } else if (params as? [String:String]) == nil {
            reqMan.getJsonRequest(params: params)
        } else {
            reqMan.getSimpleRequest(params: params as! [String:String])
        }
        
        // self.get_headers(params: params)
        
        print("Адрес -----------------------")
        print(host + path)
        
        for (key,value) in params {
            print ("\(key)=\(value)")
        }
        
        let wrap_func:(Data?,URLResponse?,Error?)-> Void = decorate(handler) { args, _ in
            let (_,res,_) = args
            guard res != nil else {
                self.delegate?.invalidate()
                return
            }
            if (res as! HTTPURLResponse).statusCode == 401 {
                self.delegate?.invalidate()
            }
        }
        
        let task = self.session.dataTask(with: reqMan.request, completionHandler: wrap_func)
        task.currentRequest?.allHTTPHeaderFields.map { key in
//            print("\(key)")
        }
        task.resume()
    }
    
    
    public func connect(path:String,params:[String:Any],handler:@escaping (Data?,URLResponse?,Error?)-> Void)
    {
        self.connect(path: path, params: params, image: nil, handler: handler)
    }
    
    // Автоматическая функция, возвращает заголовок типа если в параметрах есть русские буквы
    
    public func get_headers(params:[String:String])->[String:String]{
        for (_,value) in params {
            if value.isCyrillic {
                return ["content-type": "text/html; charset=utf-8"]
            }
        }
        return [:]
    }
    
    
        
    // это genetic функция получаем массив из словарей отдаем массив из структур
    
    public func parceTo<T:Parceble>(array:Array<[String:Any]>)->Array<T>
    {
        return array.map { item in
            return T(json: item)
        }
    }
    
    
    // TODO: Реализовать функции делегата сессии для реакции на инвалидацию и запросы авторизации
    
    
    // Функция для назначения нового url
    
    public func setHost(url:String) {
        UserData.url = url
        self.host = url
    }
    
}
