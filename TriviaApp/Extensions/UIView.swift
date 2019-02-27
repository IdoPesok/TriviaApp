//
//  UIView.swift
//  TriviaApp
//
//  Created by Ido Pesok on 2/24/19.
//  Copyright © 2019 IdoPesok. All rights reserved.
//

import UIKit

extension UIView {
    
    func anchor(top: NSLayoutYAxisAnchor?, trailing: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, centralX: NSLayoutXAxisAnchor?, centralY: NSLayoutYAxisAnchor?, size: CGSize = .zero, padding: UIEdgeInsets = .zero) {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true
        }
        
        if let trailing = trailing {
            self.trailingAnchor.constraint(equalTo: trailing, constant: -(padding.right)).isActive = true
        }
        
        if let bottom = bottom {
            self.bottomAnchor.constraint(equalTo: bottom, constant: -(padding.bottom)).isActive = true
        }
        
        if let leading = leading {
            self.leadingAnchor.constraint(equalTo: leading, constant: padding.left).isActive = true
        }
        
        if let centX = centralX {
            self.centerXAnchor.constraint(equalTo: centX).isActive = true
        }
        
        if let centY = centralY {
            self.centerYAnchor.constraint(equalTo: centY).isActive = true
        }
        
        if size.height != 0 {
            self.heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
        
        if size.width != 0 {
            self.widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        
    }
    
    func fillToSuperview() {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        if let top = superview?.topAnchor {
            self.topAnchor.constraint(equalTo: top).isActive = true
        }
        
        if let bottom = superview?.bottomAnchor {
            self.bottomAnchor.constraint(equalTo: bottom).isActive = true
        }
        
        if let leading = superview?.leadingAnchor {
            self.leadingAnchor.constraint(equalTo: leading).isActive = true
        }
        
        if let trailing = superview?.trailingAnchor {
            self.trailingAnchor.constraint(equalTo: trailing).isActive = true
        }
    }
    
}
