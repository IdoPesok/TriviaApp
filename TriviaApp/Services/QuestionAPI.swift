//
//  QuestionAPI.swift
//  TriviaApp
//
//  Created by Ido Pesok on 2/24/19.
//  Copyright © 2019 IdoPesok. All rights reserved.
//

import UIKit

class QuestionAPI {
    
    static let apiUrlString = "https://opentdb.com/api.php?amount=10"
    
    static let shared = QuestionAPI()
    
    func getTriviaQuestions(completion: @escaping ([Question]) -> Void) {
        
        guard let apiUrl = URL.init(string: QuestionAPI.apiUrlString) else {
            print("API URL is not valid")
            return
        }
        
        retrieveJsonData(apiUrl: apiUrl) { (data) in
            guard let questions = self.getQuestionsFromData(data: data) else {
                print("QUESTIONS NOT RETRIEVED")
                return
            }
            
            completion(questions)
        }
    }
    
    fileprivate func retrieveJsonData(apiUrl: URL, completion: @escaping ([[String: Any]]) -> Void) {
        
        let task = URLSession.shared.dataTask(with: apiUrl) { (data, res, err) in
            guard err == nil && data != nil else {
                print("ERROR GETTING DATA")
                return
            }
            
            guard let json = (try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers)) as? [String: Any] else {
                print("NO JSON FOUND")
                return
            }
            
            guard let results = json[APIKeys.results.rawValue] as? [[String: Any]] else {
                print("NO RESULTS FOUND")
                return
            }
            
            completion(results)
        }
        
        task.resume()
    }
    
    fileprivate func getQuestionsFromData(data: [[String: Any]]) -> [Question]? {
        var questions = [Question]()
        
        for q in data {
            guard let category = q[APIKeys.category.rawValue] as? String, let type = q[APIKeys.type.rawValue] as? String, let difficulty = q[APIKeys.difficulty.rawValue] as? String, var question = q[APIKeys.question.rawValue] as? String, var correctAnswer = q[APIKeys.correct_answer.rawValue] as? String, var incorrectAnswers = q[APIKeys.incorrect_answers.rawValue] as? [String] else {
                print("ERROR DATA VALUES NOT FOUND")
                return nil
            }
            
            question = convertSpecialCharacters(string: question)
            incorrectAnswers = incorrectAnswers.map({ convertSpecialCharacters(string: $0) })
            correctAnswer = convertSpecialCharacters(string: correctAnswer)
            
            let retrievedQuestion = Question.init(category: category, type: type, question: question, difficulty: difficulty, correct_answer: correctAnswer, incorrect_answers: incorrectAnswers)
            questions.append(retrievedQuestion)
        }
        
        return questions
    }
    
    fileprivate func convertSpecialCharacters(string: String) -> String {
        var newString = string
        let char_dictionary = [
            "&amp;": "&",
            "&lt;": "<",
            "&gt;": ">",
            "&quot;": "\"",
            "&apos;": "'",
            "&#039;": "'",
            "&eacute;": "é"
        ];
        
        for (escaped_char, unescaped_char) in char_dictionary {
            newString = newString.replacingOccurrences(of: escaped_char, with: unescaped_char, options: NSString.CompareOptions.regularExpression, range: nil)
        }
        return newString
    }
    
}
