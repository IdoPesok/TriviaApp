//
//  MenuController.swift
//  TriviaApp
//
//  Created by Ido Pesok on 2/24/19.
//  Copyright © 2019 IdoPesok. All rights reserved.
//

import UIKit

class MenuController: UIViewController {

    fileprivate let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.bold(size: 34)
        label.textAlignment = .center
        label.text = "Trivia App"
        
        return label
    }()
    
    fileprivate let startButton = MenuButton.init(title: "START")
    fileprivate let settingsButton = MenuButton.init(title: "SETTINGS")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        hideNavBar(value: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        hideNavBar(value: false)
    }
    
    fileprivate func setupViews() {
        view.backgroundColor = Colors.midnightBlue
        
        // ADD SUBVIEWS
        [titleLabel, startButton, settingsButton].forEach({ view.addSubview($0) })
        
        // TITLE LABEL
        titleLabel.anchor(top: view.topAnchor, trailing: view.trailingAnchor, bottom: nil, leading: view.leadingAnchor, centralX: nil, centralY: nil, size: .init(width: 0, height: 60), padding: .init(top: 90, left: 0, bottom: 0, right: 0))
        
        // START BUTTON
        startButton.addTarget(self, action: #selector(handleStart), for: .touchUpInside)
        startButton.anchor(top: titleLabel.bottomAnchor, trailing: view.trailingAnchor, bottom: nil, leading: view.leadingAnchor, centralX: nil, centralY: nil, size: .init(width: 0, height: 60), padding: .init(top: 100, left: 40, bottom: 0, right: 40))
        
        // SETTINGS BUTTON
        settingsButton.anchor(top: startButton.bottomAnchor, trailing: view.trailingAnchor, bottom: nil, leading: view.leadingAnchor, centralX: nil, centralY: nil, size: .init(width: 0, height: 60), padding: .init(top: 20, left: 40, bottom: 0, right: 40))
    }
    
    @objc fileprivate func handleStart() {
        navigationController?.pushViewController(TriviaController(), animated: true)
    }

}
