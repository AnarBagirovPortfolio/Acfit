//
//  LoginView.swift
//  ProjectFitry
//
//  Created by Faannaka on 01.05.17.
//  Copyright © 2017 Anar Baghirov. All rights reserved.
//

import UIKit

class LoginView: UIView {
    
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var secondNameField: UITextField!
    @IBOutlet weak var birthDateField: UIDateTextField!
    @IBOutlet weak var sexField: UISexTextField!
    @IBOutlet weak var heightField: UITextField!
    @IBOutlet weak var weightField: UITextField!
    
    @IBOutlet weak var birthDateFieldConstraint: NSLayoutConstraint!
    @IBOutlet weak var birthDateLabelConstraint: NSLayoutConstraint!
    @IBOutlet weak var heightLabelConstraint: NSLayoutConstraint!
    @IBOutlet weak var heightFieldConstraint: NSLayoutConstraint!
    
    @IBAction func editingDidBegin(_ sender: UITextField) {
        if sender == sexField {
            if sender.text?.isEmpty ?? true {
                sender.text = sexField.sex.first
            }
        }
    }
    
    override func willMove(toSuperview newSuperview: UIView?) {
        guard let view = newSuperview as? LoginView else {
            return
        }
        
        [ firstNameField, secondNameField, birthDateField, sexField, heightField, weightField ].forEach({
            $0?.useUnderline()
        })
        
        let margin = CGFloat(16)
        let width = (view.bounds.width - 3 * margin) / 2
        
        [ birthDateFieldConstraint, birthDateLabelConstraint, heightLabelConstraint, heightFieldConstraint ].forEach({
            $0?.constant = width
        })
        
        frame = view.bounds
    }
    
}
