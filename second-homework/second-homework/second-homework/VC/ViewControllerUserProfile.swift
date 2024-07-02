//
//  ViewControllerUserProfile.swift
//  second-homework
//
//  Created by Viacheslav on 02.07.2024.
//

import UIKit

class ViewControllerUserProfile: UIViewController {

    var loginToShow: String?
    
    @IBOutlet weak var userLogin: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if loginToShow != nil {
            userLogin.text = loginToShow
        }
        
        //self.navigationController?.navigationBar.barStyle = .black
        // раньше работала, я чет сделал, и перестала
        //self.navigationController?.navigationBar.tintColor = .green // цвет кнопки назад
    }
}
