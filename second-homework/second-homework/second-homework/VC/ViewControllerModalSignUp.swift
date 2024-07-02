//
//  ViewControllerToSegue.swift
//  second-homework
//
//  Created by Viacheslav on 02.07.2024.
//

import UIKit

class ViewControllerModalSignUp: UIViewController {
    var isSignUp: Bool?
    
    // Ссылка на класс, вызвавший нас
    weak var delegate: ViewControllerDelegate?

    // Введеный логин
    @IBOutlet weak var enteredLogin: UITextField!
    @IBOutlet weak var incorrectLoginLabel: UILabel!
    
    // Введеный пароль
    @IBOutlet weak var enteredPassword: UITextField!
    @IBOutlet weak var incorrectPasswordLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // по дефолту прячем их
        incorrectLoginLabel.isHidden = true
        incorrectPasswordLabel.isHidden = true
    }
    
    // функция для того, чтоб убрать красные надписи, перед тем как покинем
    // эту модальную страницу, чтоб в следюущий раз они наз не встречали
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        incorrectLoginLabel.isHidden = true
        incorrectPasswordLabel.isHidden = true
    }
    
    // Нажатие на кнопку подтверждения
    @IBAction func didPressedConfirmButton(_ sender: UIButton) {
        // просто перекрашу placeholder в красный
        if enteredLogin.text == nil || enteredPassword.text == nil {
            enteredLogin.text = String() // Присваиваю пустую строку
            enteredPassword.text = String()
            
            incorrectLoginLabel.isHidden = false
            incorrectPasswordLabel.isHidden = false
            
            return
        }
        
        // если хотя бы одно из полей пустое, то ошибка
        if let enteredLoginTextIsEmpty = enteredLogin.text?.isEmpty,
           let enteredPasswordTextIsEmpty = enteredPassword.text?.isEmpty {
            if enteredLoginTextIsEmpty || enteredPasswordTextIsEmpty {
                enteredLogin.text = String()
                enteredPassword.text = String()
                
                incorrectLoginLabel.isHidden = false
                incorrectPasswordLabel.isHidden = false
                
                return
            }
        }
        
        
        // могу себе позволить force-unwrapping, тк до этого проверки провел
        if !(isSignUp!) {
            delegate?.didReceiveData(isSignUp!, enteredLogin.text!, enteredPassword.text!)
            dismiss(animated: true)
            return
        }
        
        if let VC = delegate as? ViewController {
            if let user = VC.userDefaults.string(forKey: enteredLogin.text!) {
                // в таком случае пользователь уже существует
                showAlert(message: "User with such a login already exists") {
                    // После нажатия кнопки OK
                    print("User pressed OK")
                }
                return
            }
            else {
                // создаем нового пользователя
                VC.userDefaults.set(enteredLogin.text!, forKey: enteredPassword.text!)
            }
        }
        
        // все, уходим с этой страницы
        dismiss(animated: true)
    }
    
    // функция для вызова окна с предупреждением
    func showAlert(message: String, completion: @escaping () -> Void) {
           let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
           alertController.addAction(UIAlertAction(title: "OK", style: .default) { _ in
               completion()  // вызываем замыкания после показа сообщения, чтоб пока пользователь
               // не нажал ОК, код не выполнялся, типо он будет ждать выполнения completion(), а он
               // в свою очередь нажатия OK
           })
           self.present(alertController, animated: true, completion: nil)
       }
}
