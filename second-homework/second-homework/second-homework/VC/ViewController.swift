//
//  ViewController.swift
//  second-homework
//
//  Created by Viacheslav on 02.07.2024.
//

import UIKit

class ViewController: UIViewController, ViewControllerDelegate {
    
    // Начинаем работу с UserDefaults, будем хранить там логины и пароли (только в качестве дз кншн)
    let userDefaults = UserDefaults.standard
    
    // они вроде тоже бесполезны, но рефакторингом уже сил нет заниматься: спать хочу
    var enteredLogin: String?
    var enteredPassword: String?
    
    
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        
//        signUpButton.tintColor = .systemGreen
//        loginButton.tintColor = .systemGreen
//    }
    
    
    // не помогает
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        signUpButton.tintColor = .systemGreen
        loginButton.tintColor = .systemGreen
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SignUpModal" {
            if let destinationVC = segue.destination as? ViewControllerModalSignUp {
                // передаем ссылку на себя, чтоб модальная страница могла
                // передать нам логин и пароль
                destinationVC.delegate = self
                destinationVC.isSignUp = true // Передача булевой переменной
            }
        }
        if segue.identifier == "LoginModal" {
            if let destinationVC = segue.destination as? ViewControllerModalSignUp {
                // передаем ссылку на себя, чтоб модальная страница могла
                // передать нам логин и пароль
                destinationVC.delegate = self
                destinationVC.isSignUp = false // Передача булевой переменной
            }
        }
//        if segue.identifier == "userProfile" {
//            if let destinationVC = segue.destination as? ViewControllerUserProfile {
//                // передаем ссылку на себя, чтоб модальная страница могла
//                // передать нам логин и пароль
//                destinationVC.userLogin.text = enteredLogin
//            }
//        }
    }
        
    @IBAction func pressedSignUp(_ sender: UIButton) {
        performSegue(withIdentifier: "SignUpModal", sender: self)
    }
    
    @IBAction func pressedLogin(_ sender: UIButton) {
        performSegue(withIdentifier: "LoginModal", sender: self)
    }
    
    func didReceiveData(_ isSignUp: Bool, _ login: String, _ password: String) {
       
        self.enteredLogin = login
        self.enteredPassword = password
        
        // здесь будем обрабатывать наши строки логина и пароля
        // причем тут будет два сценария: регистрация или авторизация
        // 1) Получили данные на главный VC, добавили в "бд" и ничего не делаем
        // 2) Получили данные и передаем их странице профиля пользователя
        
        // на самом деле, это условие бессмысленное, ведь иной случай я в другом месте уже обработал
        if !isSignUp {
            let userProfileVC = storyboard?.instantiateViewController(withIdentifier: "userProfileId") as! ViewControllerUserProfile
            
            
//            var labelForUser = UILabel()
//            labelForUser.text = enteredLogin
//            labelForUser.font = .systemFont(ofSize: 30)
//            labelForUser.textColor = .green
//            
//            userProfileVC.userLogin = labelForUser
            userProfileVC.loginToShow = enteredLogin
            
            navigationController?.pushViewController(userProfileVC, animated: true)
        }
            
    }
}

