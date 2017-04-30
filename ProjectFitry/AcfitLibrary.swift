//
//  AcfitLibrary.swift
//  ProjectFitry
//
//  Created by Faannaka on 30.04.17.
//  Copyright © 2017 Anar Baghirov. All rights reserved.
//

import Foundation
import UIKit

class AcfitLibrary {
    private init() { }
    
    static let shared = AcfitLibrary()
    
    enum StatusBarColor {
        case white
        case black
    }
    
    func set(statusBarColor color: StatusBarColor) {
        if color == StatusBarColor.black {
            UIApplication.shared.statusBarStyle = .default
        } else {
            UIApplication.shared.statusBarStyle = .lightContent
        }
    }
}
