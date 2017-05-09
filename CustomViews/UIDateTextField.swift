//
//  UIDateTextField.swift
//  ProjectFitry
//
//  Created by Faannaka on 04.05.17.
//  Copyright © 2017 Anar Baghirov. All rights reserved.
//

import UIKit

class UIDateTextField: UITextField {

    private lazy var _inputView: UIView? = {
        let picker = UIDatePicker()
        
        picker.datePickerMode = .date
        picker.date = Date()
        picker.layer.backgroundColor = UIColor.pickerColor.cgColor
        picker.setValue(UIColor.white, forKey: "textColor")
        picker.addTarget(self, action: #selector(datePickerValueChanged), for: UIControlEvents.valueChanged)
        
        return picker
    }()
    
    lazy var datePickerDateFormatter: DateFormatter! = {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = DateFormatter.Style.medium
        dateFormatter.timeStyle = DateFormatter.Style.none
        
        return dateFormatter
    }()
    
    func date() -> Date? {
        if self.empty() {
            return nil
        } else {
            return datePickerDateFormatter.date(from: self.text!)
        }
    }
    
    override var inputView: UIView? {
        get {
            return _inputView
        } set {
            _inputView = newValue
        }
    }

}

extension UIDateTextField {
    func datePickerValueChanged(sender: UIDatePicker) {
        text = self.datePickerDateFormatter.string(from: sender.date)
    }
}
