
import Foundation


open class UserData {
    
    open static var standart:UserDefaults {
        get {
            return UserDefaults.standard
        }
    }
    
//    static var id:String {
//        get {
//            let standart = UserDefaults.standard
//            guard standart.string(forKey: "user_id") != nil else {
//                return ""
//            }
//            return standart.string(forKey: "user_id")!
//        }
//        
//        set {
//            let standart = UserDefaults.standard
//            standart.set(newValue, forKey: "user_id")
//        }
//    }
//    
//    static var isFirstTime:Bool {
//        get {
//            let standart = UserDefaults.standard
//            guard standart.string(forKey: "firstUp") != nil else {
//                return true
//            }
//            return standart.string(forKey: "firstUp") == "1"
//        }
//        
//        set {
//            let standart = UserDefaults.standard
//            standart.set(newValue ? "1" : "0", forKey: "firstUp")
//        }
//    }
    
    public static var url:String? {
        get {
            return standart.string(forKey: "cur_url")
        }
        
        set {
            standart.set(newValue, forKey: "cur_url")
        }
    }
    
//    static var pushReport: ReportItem?
//    static var userLoggedIn:Bool{
//        get {
//            let standart = UserDefaults.standard
//            return standart.bool(forKey: "userLoggedIn")
//        }
//        set {
//            let standart = UserDefaults.standard
//            standart.set(newValue, forKey: "userLoggedIn")
//        }
//    }
//    
//    static var lastLoginDate:Double{
//        get {
//            let standart = UserDefaults.standard
//            return standart.double(forKey: "lastLoginDate")
//        }
//        set {
//            let standart = UserDefaults.standard
//            standart.set(newValue, forKey: "lastLoginDate")
//        }
//    }
    
    // написать свойство с типом Date
}
