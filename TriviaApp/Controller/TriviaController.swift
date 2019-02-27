//
//  ViewController.swift
//  TriviaApp
//
//  Created by Ido Pesok on 2/24/19.
//  Copyright © 2019 IdoPesok. All rights reserved.
//

import UIKit
import ProgressHUD

class TriviaController: UIViewController {

    fileprivate var questionCounter = -1
    fileprivate var numberCorrect = 0
    
    fileprivate var questions = [Question]()
    
    fileprivate let questionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.regular(size: 24)
        label.textAlignment = .center
        label.text = "Trivia App"
        label.numberOfLines = 0
        
        return label
    }()
    
    fileprivate let exitButton: UIButton = {
        let btn = UIButton.init(type: .system)
        btn.setTitle("X", for: .normal)
        btn.titleLabel?.font = UIFont.bold(size: 40)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.backgroundColor = Colors.midnightBlue
        
        return btn
    }()
    
    fileprivate let scoreLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "0 / 10"
        lbl.font = UIFont.bold(size: 24)
        lbl.textColor = UIColor.white
        lbl.backgroundColor = Colors.midnightBlue
        lbl.textAlignment = .right
        
        return lbl
    }()
    
    fileprivate let progressBar: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.electricBlue
        
        return view
    }()
    fileprivate var progressBarWidthAnchor: NSLayoutConstraint?
    
    let answerButtonOne = AnswerButton()
    let answerButtonTwo = AnswerButton()
    let answerButtonThree = AnswerButton()
    let answerButtonFour = AnswerButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getQuestions()
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
        [questionLabel, exitButton, answerButtonOne, answerButtonTwo, answerButtonThree, answerButtonFour, scoreLabel, progressBar].forEach({ view.addSubview($0) })
        
        // EXIT BUTTON
        exitButton.addTarget(self, action: #selector(handleExit), for: .touchUpInside)
        exitButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, trailing: nil, bottom: nil, leading: view.leadingAnchor, centralX: nil, centralY: nil, size: .init(width: 50, height: 50), padding: .init(top: 15, left: 15, bottom: 0, right: 0))
        
        // QUESTION NUMBER LABEL
        scoreLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, trailing: view.trailingAnchor, bottom: nil, leading: nil, centralX: nil, centralY: nil, size: .init(width: view.frame.width / 2, height: 50), padding: .init(top: 15, left: 0, bottom: 0, right: 15))
        
        // QUESTION LABEL
        questionLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, trailing: view.trailingAnchor, bottom: nil, leading: view.leadingAnchor, centralX: nil, centralY: nil, size: .init(width: 0, height: 200), padding: .init(top: 80, left: 35, bottom: 0, right: 35))
        
        // ANSWER BUTTON ONE
        answerButtonOne.addTarget(self, action: #selector(handleAnswer(sender:)), for: .touchUpInside)
        answerButtonOne.anchor(top: nil, trailing: view.trailingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, leading: view.leadingAnchor, centralX: nil, centralY: nil, size: .init(width: 0, height: 50), padding: .init(top: 0, left: 40, bottom: 50, right: 40))
        
        // ANSWER BUTTON TWO
        answerButtonTwo.addTarget(self, action: #selector(handleAnswer(sender:)), for: .touchUpInside)
        answerButtonTwo.anchor(top: nil, trailing: view.trailingAnchor, bottom: answerButtonOne.topAnchor, leading: view.leadingAnchor, centralX: nil, centralY: nil, size: .init(width: 0, height: 50), padding: .init(top: 0, left: 40, bottom: 10, right: 40))
        
        // ANSWER BUTTON THREE
        answerButtonThree.addTarget(self, action: #selector(handleAnswer(sender:)), for: .touchUpInside)
        answerButtonThree.anchor(top: nil, trailing: view.trailingAnchor, bottom: answerButtonTwo.topAnchor, leading: view.leadingAnchor, centralX: nil, centralY: nil, size: .init(width: 0, height: 50), padding: .init(top: 0, left: 40, bottom: 10, right: 40))
        
        // ANSWER BUTTON FOUR
        answerButtonFour.addTarget(self, action: #selector(handleAnswer(sender:)), for: .touchUpInside)
        answerButtonFour.anchor(top: nil, trailing: view.trailingAnchor, bottom: answerButtonThree.topAnchor, leading: view.leadingAnchor, centralX: nil, centralY: nil, size: .init(width: 0, height: 50), padding: .init(top: 0, left: 40, bottom: 10, right: 40))
        
        // PROGRESS BAR
        progressBar.anchor(top: nil, trailing: nil, bottom: view.safeAreaLayoutGuide.bottomAnchor, leading: view.leadingAnchor, centralX: nil, centralY: nil, size: .init(width: 0, height: 10), padding: .zero)
        progressBarWidthAnchor = progressBar.widthAnchor.constraint(equalToConstant: 0)
        progressBarWidthAnchor?.isActive = true
    }
    
    fileprivate func getQuestions() {
        QuestionAPI.shared.getTriviaQuestions { (questions) in
            self.questions = questions
            
            DispatchQueue.main.async {
                self.questionCounter = -1
                self.numberCorrect = 0
                self.setupViews()
                self.handleNextQuestion()
            }
        }
    }
    
    fileprivate func handleNextQuestion() {
        questionCounter += 1
        guard questionCounter < 10 else {
            handleEnd()
            return
        }
        
        updateLabels()
        updateButtons()
        updateProgressBar()
    }
    
    fileprivate func updateLabels() {
        let newQuestion = self.questions[questionCounter]
        
        self.questionLabel.text = newQuestion.question
        self.scoreLabel.text = "\(numberCorrect) / 10"
    }
    
    fileprivate func updateButtons() {
        let newQuestion = self.questions[questionCounter]
        
        var answerBtns = [answerButtonOne, answerButtonTwo, answerButtonThree, answerButtonFour]
        var allAnswers = newQuestion.incorrect_answers
        allAnswers.append(newQuestion.correct_answer)
        allAnswers.shuffle()
        
        for answer in allAnswers {
            answerBtns[0].changeTitle(title: answer)
            answerBtns[0].isHidden = false
            let _ = answerBtns.removeFirst()
        }
        
        for btn in answerBtns {
            btn.isHidden = true
        }
    }
    
    fileprivate func updateProgressBar() {
        let widthVal = CGFloat(questionCounter + 1) / 10 * view.frame.width
        progressBarWidthAnchor?.constant = widthVal
    }
    
    @objc fileprivate func handleAnswer(sender: UIButton) {
        guard questionCounter < 10 else {
            return
        }
        
        if sender.titleLabel?.text == self.questions[questionCounter].correct_answer {
            numberCorrect += 1
            ProgressHUD.showSuccess("Correct!")
            handleNextQuestion()
        } else {
            ProgressHUD.showError("Incorrect!")
            handleNextQuestion()
        }
    }
    
    fileprivate func handleEnd() {
        let alertController = UIAlertController.init(title: "Quiz Has Finished", message: "Your final score was \(numberCorrect) / 10", preferredStyle: .alert)
        
        let restartAction = UIAlertAction.init(title: "Restart", style: .default) { (action) in
            self.handleRestart()
        }
        
        let exitAction = UIAlertAction.init(title: "Exit", style: .destructive) { (action) in
            self.handleExit()
        }
        
        alertController.addAction(restartAction)
        alertController.addAction(exitAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    fileprivate func handleRestart() {
        self.getQuestions()
    }
    
    @objc fileprivate func handleExit() {
        navigationController?.popViewController(animated: true)
    }

}

