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
    @IBOutlet weak var birthDateTextField: UIDateTextField!
    @IBOutlet weak var sexTextField: UISexTextField!
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var heightTextField: UITextField!
    @IBOutlet weak var birthDateLabelWidth: NSLayoutConstraint!
    @IBOutlet weak var birthDateFieldWidth: NSLayoutConstraint!
    @IBOutlet weak var weightLabelWidth: NSLayoutConstraint!
    @IBOutlet weak var weightFieldWidth: NSLayoutConstraint!
    @IBOutlet weak var loginButton: UIButton!
    
    @IBAction func editingDidBegin(_ sender: UITextField) {
        if let view = sender as? UISexTextField {
            if view.text?.isEmpty ?? true {
                view.text = view.sex[0]
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
