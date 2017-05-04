//
//  UISexTextField.swift
//  ProjectFitry
//
//  Created by Faannaka on 04.05.17.
//  Copyright © 2017 Anar Baghirov. All rights reserved.
//

import UIKit

class UISexTextField: UITextField {

    var sex = [ "Male", "Female" ]
    
    private lazy var _inputView: UIView? = {
        let view = UIPickerView()
        
        view.dataSource = self
        view.delegate = self
        
        return view
    }()
    
    override var inputView: UIView? {
        get {
            return _inputView
        } set {
            _inputView = newValue
        }
    }

}

extension UISexTextField: UIPickerViewDelegate, UIPickerViewDataSource {
    internal func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    internal func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return sex.count
    }
    
    internal func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return sex[row]
    }
    
    internal func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        text = sex[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        return NSAttributedString(string: sex[row], attributes: [NSForegroundColorAttributeName : UIColor.white])
    }
}
