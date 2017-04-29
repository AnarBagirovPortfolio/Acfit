//
//  ViewController.swift
//  ProjectFitry
//
//  Created by Faannaka on 26.04.17.
//  Copyright © 2017 Anar Baghirov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var menuHeight: NSLayoutConstraint!
    
    @IBAction func addButtonClicked(sender: Any) {
        menuHeight.constant = menuHeight.constant == 64 ? 128 : 64
        self.label.textAlignment = .center
        
        UIView.animate(withDuration: 2, delay: 0.0, options: [.transitionCrossDissolve], animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIApplication.shared.statusBarStyle = .lightContent
        
        label.text = "New text from A"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    internal func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = "Row " + String(indexPath.row)
        
        return cell
    }
}
