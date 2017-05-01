//
//  LoginController.swift
//  ProjectFitry
//
//  Created by Faannaka on 30.04.17.
//  Copyright © 2017 Anar Baghirov. All rights reserved.
//

import UIKit

class LoginController: UIViewController {
    
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet weak var loginView: UIView!
    @IBOutlet weak var fullNameTextField: UITextField!
    @IBOutlet weak var birthDateTextField: UITextField!
    @IBOutlet weak var sexTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var heightTextField: UITextField!
    
    @IBAction func textEditingDidBegin(_ sender: UITextField) {
        if sender == sexTextField {
            configure("sexTextField")
        } else if sender == weightTextField {
            configure("weightTextField")
        } else if sender == heightTextField {
            configure("heightTextField")
        } else {
            configure("otherTextField")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configure("before")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        configure("after")
    }
    
}

extension LoginController {
    func configure(_ configuration: String) {
        if configuration == "before" {
            let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
            
            AcfitLibrary.set(statusBarColor: .white)
            UIApplication.shared.statusBarView?.backgroundColor = .mainColor
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: .UIKeyboardWillHide, object: nil)
            view.addGestureRecognizer(tap)
            
            //Configure text fields
            [fullNameTextField, birthDateTextField, sexTextField, weightTextField, heightTextField].forEach { textField in
                textField?.useUnderline()
            }
            
            //Initial value for top constraint before starting animating
            topConstraint.constant = view.bounds.height
            
            //Configure loginView
            loginView.layer.cornerRadius = 10
            loginView.layer.shadowOffset = CGSize(width: 0, height: 0)
            loginView.layer.shadowColor = UIColor.black.cgColor
            loginView.layer.shadowOpacity = 0.5
        } else if configuration == "after" {
            //Starting animating
            self.topConstraint.constant = (self.view.bounds.height - self.heightConstraint.constant) / 2
            
            AcfitLibrary.animateBottomUp {
                self.view.layoutIfNeeded()
            }
        } else if configuration == "sexTextField" {
            self.topConstraint.constant = (self.view.bounds.height - self.heightConstraint.constant) / 4
            
            AcfitLibrary.animateLoginView {
                self.view.layoutIfNeeded()
            }
        } else if configuration == "weightTextField" {
            self.topConstraint.constant = -10
            
            AcfitLibrary.animateLoginView {
                self.view.layoutIfNeeded()
            }
        } else if configuration == "heightTextField" {
            self.topConstraint.constant = -30
            
            AcfitLibrary.animateLoginView {
                self.view.layoutIfNeeded()
            }
        } else if configuration == "otherTextField" {
            self.topConstraint.constant = (self.view.bounds.height - self.heightConstraint.constant) / 2
            
            AcfitLibrary.animateLoginView {
                self.view.layoutIfNeeded()
            }
        }
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func keyboardWillHide() {
        configure("otherTextField")
    }
}
