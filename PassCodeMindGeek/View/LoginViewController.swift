//
//  LoginViewController.swift
//  PassCodeMindGeek
//
//  Created by Rafael Cunha de Oliveira on 2020-04-22.
//  Copyright © 2020 Rafael Cunha de Oliveira. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    //MARK: Outlets

    @IBOutlet weak var incorrectPassLabel: UILabel!
    @IBOutlet weak var appLockedLabel: UILabel!
    @IBOutlet weak var passCode: PassCode!

    //MARK: Variables

    var attempts = 0

    //MARK: Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func viewWillAppear(_ animated: Bool) {
        incorrectPassLabel.isHidden = true
        appLockedLabel.isHidden = User.sharedInstace.blocked == nil
        self.navigationItem.hidesBackButton = true
        setUpPassCode()
        appStatus()
    }

    //MARK: SetUp

    func setUpPassCode() {
        passCode.delegate = self
        passCode.becomeFirstResponder()
    }

    func appStatus() {
        if let blockDate = User.sharedInstace.blocked {
            var seconds = Date().timeIntervalSince(blockDate)
            seconds = 240 - seconds
            if seconds < 0 {
                unlockApp()
            } else {
                lockApp(seconds)
            }
        }
    }

    //MARK: Actions

    func passwordIncorrect() {
        if attempts > 1 {
            User.sharedInstace.blocked = Date()
            attempts = 0
            appStatus()
        } else {
            incorrectPassLabel.isHidden = false
            attempts += 1
        }
    }

    func lockApp(_ seconds: Double) {
        appLockedLabel.isHidden = false
        self.view.isUserInteractionEnabled = false
        passCode.resignFirstResponder()
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            self.unlockApp()
        }
    }

    func unlockApp() {
        self.appLockedLabel.isHidden = true
        self.incorrectPassLabel.isHidden = true
        User.sharedInstace.blocked = nil
        passCode.becomeFirstResponder()
        self.view.isUserInteractionEnabled = true
    }
}

extension LoginViewController: PassCodeDelegate {
    func finishEnterCode(_ code: String) {
        if User.sharedInstace.code == code {
            User.sharedInstace.isLogged = true
            self.navigationController?.popToRootViewController(animated: true)
        } else {
            passCode.code = ""
            passwordIncorrect()
        }
    }
}
