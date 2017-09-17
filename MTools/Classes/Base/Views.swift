//
//  Views.swift
//  Pods
//
//  Created by Mikhail Maltsev on 18.09.17.
//
//

import Foundation

public extension UIView {
    public class func loadFromNibNamed(nibNamed: String, bundle : Bundle? = nil) -> UIView? {
        return UINib(
            nibName: nibNamed,
            bundle: bundle
            ).instantiate(withOwner: nil, options: nil)[0] as? UIView
    }
}
