//
//  HelperString.swift
//  FSMobile
//
//  Created by Aziz Said-Malik on 17.12.16.
//  Copyright © 2016 Aziz Said-Malik. All rights reserved.
//

import Foundation
import UIKit
// Code from http://stackoverflow.com/questions/38722464/check-if-string-latin-or-cyrillic 
// need to write own


// Расширение для определения есть ли в строке русские буквы

extension String {
    var isLatin: Bool {
        let upper = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        let lower = "abcdefghijklmnopqrstuvwxyz"
        
        for c in self.characters.map({ String($0) }) {
            if !upper.contains(c) && !lower.contains(c) {
                return false
            }
        }
        
        return true
    }
    
    var isCyrillic: Bool {
        let upper = "АБВГДЕЖЗИЙКЛМНОПРСТУФХЦЧШЩЬЮЯ"
        let lower = "абвгдежзийклмнопрстуфхцчшщьюя"
        
        for c in self.characters.map({ String($0) }) {
            if !upper.contains(c) && !lower.contains(c) {
                return false
            }
        }
        
        return true
    }
    
    var isBothLatinAndCyrillic: Bool {
        return self.isLatin && self.isCyrillic
    }
}
//extension UILabel {
//    func htmlRecognizer(html: String) {
//        if let htmlData = html.data(using: String.Encoding.unicode) {
//            do {
//                self.attributedText = try NSAttributedString(data: htmlData,
//                                                             options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType],
//                                                             documentAttributes: nil)
//            } catch let e as NSError {
//                print("Couldn't parse \(html): \(e.localizedDescription)")
//            }
//        }
//    }
//}

//
//
//func converFromHtml(html: String?) -> NSAttributedString? {
//    var resutltString: NSAttributedString? = nil
//    
//
//    var tmp_html = html
//    if html == nil {tmp_html = ""}
//    
//    if let htmlData = html?.data(using: String.Encoding.unicode) {
//        do {
//            resutltString = try NSAttributedString(data: htmlData,
//                                                   options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType, NSForegroundColorAttributeName : MOLBULAK_FONT_SIZE_DEFAULT],
//                                                        documentAttributes: nil)
//        } catch let e as NSError {
//            print("Couldn't parse \(html): \(e.localizedDescription)")
//        }
//    }
//    
//    
//    
//    if resutltString != nil {
//        return  resutltString
//    }
//    else {
//       return resutltString =  NSAttributedString(string:"")
//    }
//}

//func converFromHtml(html: String?) -> NSAttributedString {
//    var resutltString = NSMutableAttributedString(string:"")
//    
//    guard let html = html else {
//        return resutltString
//    }
//
//    if let htmlData = html.data(using: String.Encoding.unicode) {
//        do {
//            resutltString = try NSMutableAttributedString(data: htmlData,
//                                                   options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,
//                                                             NSFontAttributeName: UIFont.defaultFront(ofSize: 16)],
//                                                   documentAttributes: nil)
//        } catch let e as NSError {
//            print("Couldn't parse \(html): \(e.localizedDescription)")
//        }
//    }
//    
//    return  resutltString
//}


public func trimFloat(number:String?)->String {
    guard number != nil else {
        return "0.00"
    }

    var arr = number!.components(separatedBy: ".")
    if arr.count < 2 {
        return number!
    }
    let index = arr[1].index(arr[1].startIndex, offsetBy: 2)
    return [arr[0],arr[1].substring(to: index)].joined(separator: ".")
}
