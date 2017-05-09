//
//  Extensions.swift
//  ProjectFitry
//
//  Created by Faannaka on 02.05.17.
//  Copyright © 2017 Anar Baghirov. All rights reserved.
//

import Foundation
import UIKit

// MARK : UIApplication

extension UIApplication {
    var statusBarView: UIView? {
        return value(forKey: "statusBar") as? UIView
    }
}

// MARK : UIColor

extension UIColor {
    class var placeholderColor: UIColor {
        return UIColor(hex: 0xC7C7CD, alpha: 0.5)
    }
    
    class var mainColor: UIColor {
        return UIColor(hex: 0x0E3D4C, alpha: 0.8)
    }
    
    class var pickerColor: UIColor {
        return UIColor(hex: 0x5A656C)
    }
    
    convenience init(hex: UInt32, alpha: CGFloat = 1) {
        let red = CGFloat((hex & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((hex & 0xFF00) >> 8) / 255.0
        let blue = CGFloat(hex & 0xFF) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}

// MARK : UITextField

extension UITextField {
    func useUnderline() {
        let border = CALayer()
        let borderWidth = CGFloat(1.0)
        border.borderColor = UIColor.placeholderColor.cgColor
        border.frame = CGRect(origin: CGPoint(x: 0,y :self.frame.size.height - borderWidth), size: CGSize(width: self.frame.size.width, height: self.frame.size.height))
        border.borderWidth = borderWidth
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
    
    func empty() -> Bool {
        return self.text?.isEmpty ?? true
    }
}

// MARK : UIButton

extension UIButton {
    func set(enable: Bool) {
        self.isEnabled = enable
        self.alpha = enable ? 1 : 0.5
    }
}

// MARK : String

extension String {
    func toDouble() -> Double? {
        return Double(self.replacingOccurrences(of: ",", with: "."))
    }
}

// MARK : String?

extension Optional where Wrapped == String {
    func toDouble() -> Double? {
        return self == nil ? nil : self!.toDouble()
    }
}

