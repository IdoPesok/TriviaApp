//
//  UIFont.swift
//  TriviaApp
//
//  Created by Ido Pesok on 2/27/19.
//  Copyright © 2019 IdoPesok. All rights reserved.
//

import UIKit

extension UIFont {
    
    static func bold(size: CGFloat) -> UIFont {
        return UIFont.init(name: "Roboto-Bold", size: size)!
    }
    
    static func regular(size: CGFloat) -> UIFont {
        return UIFont.init(name: "Roboto-Regular", size: size)!
    }
    
}
