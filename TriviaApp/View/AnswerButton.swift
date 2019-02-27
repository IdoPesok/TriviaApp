//
//  AnswerButton.swift
//  TriviaApp
//
//  Created by Ido Pesok on 2/27/19.
//  Copyright © 2019 IdoPesok. All rights reserved.
//

import UIKit

class AnswerButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = Colors.clouds
        self.titleLabel?.font = UIFont.bold(size: 18)
        self.setTitleColor(Colors.wetAsphalt, for: .normal)
        self.titleLabel?.adjustsFontSizeToFitWidth = true
    }
    
    func changeTitle(title: String) {
        self.setTitle(title, for: .normal)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
