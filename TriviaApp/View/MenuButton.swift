//
//  MenuButton.swift
//  TriviaApp
//
//  Created by Ido Pesok on 2/27/19.
//  Copyright © 2019 IdoPesok. All rights reserved.
//

import UIKit

class MenuButton: UIButton {
    
    init(title: String) {
        super.init(frame: .zero)
        
        self.backgroundColor = Colors.electricBlue
        self.titleLabel?.font = UIFont.bold(size: 18)
        self.setTitle(title, for: .normal)
        self.setTitleColor(UIColor.white, for: .normal)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
