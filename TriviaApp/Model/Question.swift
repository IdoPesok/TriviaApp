//
//  Question.swift
//  TriviaApp
//
//  Created by Ido Pesok on 2/24/19.
//  Copyright © 2019 IdoPesok. All rights reserved.
//

import UIKit

struct Question {
    
    let category: String
    let type: String
    let question: String
    let difficulty: String
    let correct_answer: String
    let incorrect_answers: [String]
    
}
