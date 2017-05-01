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
    
    override func willMove(toSuperview newSuperview: UIView?) {
        if let view = newSuperview as? LoginView {
            let margin = CGFloat(16)
            let width = (view.bounds.width - 3 * margin) / 2
            
            [ birthDateFieldWidth, birthDateLabelWidth, weightLabelWidth, weightFieldWidth ].forEach { constraint in
                constraint?.constant = width
            }
            
            [ fullNameTextField, birthDateTextField, sexTextField, weightTextField, heightTextField ].forEach { field in
                field?.useUnderline()
            }
            
            self.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 320)
        }
    }
    
}
