//
//  ConfirmPasscodeViewController.swift
//  PassCodeMindGeek
//
//  Created by Rafael Cunha de Oliveira on 2020-04-21.
//  Copyright © 2020 Rafael Cunha de Oliveira. All rights reserved.
//

import UIKit

class ConfirmPasscodeViewController: UIViewController {

    //MARK: Outlets

    @IBOutlet weak var passCode: PassCode!

    //MARK: Variable

    var newPassCode = ""

    //MARK: Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpPassCode()
    }

    //MARK: SetUp

    func setUpPassCode() {
        passCode.delegate = self
        passCode.becomeFirstResponder()
    }

}

extension ConfirmPasscodeViewController: PassCodeDelegate {
    func finishEnterCode(_ code: String) {
        if code == newPassCode {
            User.sharedInstace.code = code
            User.sharedInstace.isLogged = true
            self.navigationController?.popToRootViewController(animated: true)
        } else {
            showAlert(title: "Error", message: "PassCode does not match")
            passCode.code = ""
        }
    }
}
