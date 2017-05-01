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
    
    lazy var standardTopConstraint: CGFloat = {
        return (self.view.bounds.height - self.heightConstraint.constant) / 2
    }()
    
    lazy var openKeyboardTopConstraint: CGFloat = {
        return 30
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let loginView = Bundle.main.loadNibNamed("LoginView", owner: self, options: nil)?.first as? LoginView {
            self.loginView.addSubview(loginView)
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: .UIKeyboardWillHide, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: .UIKeyboardWillShow, object: nil)
        AcfitLibrary.shared.set(statusBarColor: .white)
        AcfitLibrary.shared.set(statusBarBackgroundColor: .mainColor)
        
        view.addGestureRecognizer({
            return UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        }())
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        topConstraint.constant = view.bounds.height
    }
    
    override func viewDidAppear(_ animated: Bool) {
        topConstraint.constant = self.standardTopConstraint
        
        AcfitLibrary.shared.animateBottomUp {
            self.view.layoutIfNeeded()
        }
    }
    
}

extension LoginController {
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func keyboardWillHide() {
        topConstraint.constant = self.standardTopConstraint
        
        AcfitLibrary.shared.animateLoginView {
            self.view.layoutIfNeeded()
        }
    }
    
    func keyboardWillShow(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            topConstraint.constant = standardTopConstraint - keyboardSize.height / 2
        } else {
            topConstraint.constant = openKeyboardTopConstraint
        }
        
        AcfitLibrary.shared.animateLoginView {
            self.view.layoutIfNeeded()
        }
    }
}
