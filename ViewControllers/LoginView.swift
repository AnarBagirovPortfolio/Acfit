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
            
            birthDateFieldWidth.constant = width
            birthDateLabelWidth.constant = width
            weightLabelWidth.constant = width
            weightFieldWidth.constant = width
            
            [ fullNameTextField, birthDateTextField, sexTextField, weightTextField, heightTextField ].forEach { field in
                field?.useUnderline()
            }
            
            self.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 320)
        }
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
