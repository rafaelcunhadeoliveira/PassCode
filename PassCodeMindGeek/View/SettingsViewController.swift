//
//  SettingsViewController.swift
//  PassCodeMindGeek
//
//  Created by Rafael Cunha de Oliveira on 2020-04-21.
//  Copyright © 2020 Rafael Cunha de Oliveira. All rights reserved.
//

import UIKit
import CoreData

class SettingsViewController: UIViewController {

    //MARK: - Outlet

    @IBOutlet weak var passCodeSwitch: UISwitch!

    //MARK: Variables

    lazy var assistant: CoreDataAssistant = {
        return CoreDataAssistant()
    }()
    
    //MARK: Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        addObservable()
        fechUser()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if !User.sharedInstace.isLogged ||
            User.sharedInstace.blocked != nil {
            goToLogin()
        }
        passCodeSwitch.isOn = passNeeded()
    }

    //MARK: - Setup
    
    func addObservable() {
        let notification = NotificationCenter.default
        notification.addObserver(self,
                                 selector: #selector(goToLogin),
                                 name: UIApplication.willEnterForegroundNotification,
                                 object: nil)
        notification.addObserver(self,
                                 selector: #selector(saveUser),
                                 name: UIApplication.didEnterBackgroundNotification,
                                 object: nil)
    }

    //MARK: - Actions

    @IBAction func activatePasscode(_ sender: UISwitch) {
        if sender.isOn {
            performSegue(withIdentifier: "showPassCode", sender: nil)
        } else {
            User.sharedInstace.code = ""
        }
    }

    func fechUser() {
        assistant.fetchUser()
    }

    @objc func saveUser() {
        User.sharedInstace.isLogged = false
        assistant.save()
    }

    @objc private func goToLogin() {
        if passNeeded() {
            performSegue(withIdentifier: "login", sender: nil)
        }
    }

    //MARK: - Validations

    func passNeeded() -> Bool {
        return !(User.sharedInstace.code.isEmpty)
    }
    
}
