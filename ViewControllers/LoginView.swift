//
//  LoginView.swift
//  ProjectFitry
//
//  Created by Faannaka on 01.05.17.
//  Copyright © 2017 Anar Baghirov. All rights reserved.
//

import UIKit

class LoginView: UIView {
    
    func textFields() -> [ UITextField ] {
        return [ firstNameField, secondNameField, birthDateField, sexField, heightField, weightField ]
    }
    
    func allDataAdded() -> Bool {
        return textFields().map({ $0.empty() }).filter({ $0 }).count == 0
    }
    
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
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var setImageButton: UIButton!
    @IBOutlet weak var logo: UIImageView!
    
    @IBAction func editingDidBegin(_ sender: UITextField) {
        if sender == sexField {
            if sender.empty() {
                sender.text = sexField.sex.first
            }
        }
    }
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        loginButton.set(enable: false)
        
        guard let firstName = firstNameField.text,
            let secondName = secondNameField.text,
            let sex = sexField.text,
            let birthDate = birthDateField.date(),
            let weight = weightField.text.toDouble(),
            let height = heightField.text.toDouble() else {
                return
        }
        
        let id = UUID().uuidString
        let name = firstName + " " + secondName
        
        let customer = CoreDataStack.shared.create(Customer.self)
        
        customer.id = id
        customer.name = name
        customer.sex = sex
        customer.birthDate = birthDate as NSDate
        customer.weightInKg = weight
        customer.heightInMetr = height
        customer.image = {
            if logo.image == nil {
                return nil
            } else {
                guard let imageData = UIImagePNGRepresentation(logo.image!) else {
                    return nil
                }
                
                return NSData(data: imageData)
            }
        }()
        
        CoreDataStack.shared.saveContext()
    }
    
    @IBAction func editingChanged(_ sender: UITextField) {
        if sender.empty() {
            loginButton.set(enable: false)
        } else {
            loginButton.set(enable: allDataAdded())
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
        
        loginButton.set(enable: false)
        frame = view.bounds
    }

}
