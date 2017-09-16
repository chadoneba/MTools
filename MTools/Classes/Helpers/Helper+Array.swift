
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

