
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
