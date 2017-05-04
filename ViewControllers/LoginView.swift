//
//  LoginView.swift
//  ProjectFitry
//
//  Created by Faannaka on 01.05.17.
//  Copyright © 2017 Anar Baghirov. All rights reserved.
//

import UIKit

class LoginView: UIView {
    
    @IBOutlet weak var fullNameTextField: UITextField!
    @IBOutlet weak var birthDateTextField: UITextField!
    @IBOutlet weak var sexTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var heightTextField: UITextField!
    @IBOutlet weak var birthDateLabelWidth: NSLayoutConstraint!
    @IBOutlet weak var birthDateFieldWidth: NSLayoutConstraint!
    @IBOutlet weak var weightLabelWidth: NSLayoutConstraint!
    @IBOutlet weak var weightFieldWidth: NSLayoutConstraint!
    @IBOutlet weak var loginButton: UIButton!
    
    var sex = [ "Male", "Female" ]
    
    lazy var sexPickerView: UIPickerView = {
        let view = UIPickerView()
        
        view.delegate = self
        view.dataSource = self
        view.backgroundColor = UIColor.clear
        view.selectedRow(inComponent: 0)
        
        return view
    }()
    
    lazy var datePickerDateFormatter: DateFormatter! = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.medium
        dateFormatter.timeStyle = DateFormatter.Style.none
        
        return dateFormatter
    }()
    
    lazy var datePicker: UIDatePicker! = {
        let picker = UIDatePicker()
        
        picker.datePickerMode = .date
        picker.addTarget(self, action: #selector(self.datePickerValueChanged), for: UIControlEvents.valueChanged)
        
        return picker
    }()
    
    @IBAction func editingDidBegin(_ sender: UITextField) {
        if sender == sexTextField {
            if sender.inputView != sexPickerView {
                sender.inputView = sexPickerView
                sender.text = sex[0]
            }
        } else if sender == birthDateTextField {
            if sender.inputView != datePicker {
                datePicker.date = Date()
                sender.inputView = datePicker
            }
        }
    }
    
    override func willMove(toSuperview newSuperview: UIView?) {
        guard let view = newSuperview as? LoginView else {
            return
        }
        
        let margin = CGFloat(16)
        let width = (view.bounds.width - 3 * margin) / 2
        
        [ birthDateFieldWidth, birthDateLabelWidth, weightLabelWidth, weightFieldWidth ].forEach { constraint in
            constraint?.constant = width
        }
        
        [ fullNameTextField, birthDateTextField, sexTextField, weightTextField, heightTextField ].forEach { field in
            field?.useUnderline()
        }
        
        loginButton.set(enable: false)
        
        frame = view.bounds
    }
    
}

extension LoginView: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return sex.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return sex[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        sexTextField.text = sex[row]
    }
    
    func datePickerValueChanged(sender: UIDatePicker) {
        birthDateTextField.text = datePickerDateFormatter.string(from: sender.date)
    }
}
