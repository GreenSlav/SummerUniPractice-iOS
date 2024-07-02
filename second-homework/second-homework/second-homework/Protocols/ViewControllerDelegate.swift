//
//  ViewControllerDelegate.swift
//  second-homework
//
//  Created by Viacheslav on 02.07.2024.
//

import Foundation
import UIKit

// указав наследование от AnyObject, мы поясняем, что наследоваться от этого
// протокола могут только классы
// это нужно, чтобы в будущем указать слабую ссылку на наследников
protocol ViewControllerDelegate: AnyObject {
    func didReceiveData(_ isSignUp: Bool, _ login: String, _ password: String)
}
