//
//  NewPassCodeViewController.swift
//  PassCodeMindGeek
//
//  Created by Rafael Cunha de Oliveira on 2020-04-21.
//  Copyright © 2020 Rafael Cunha de Oliveira. All rights reserved.
//

import UIKit

class NewPassCodeViewController: UIViewController {

    //MARK: Outlets

    @IBOutlet weak var passCode: PassCode!

    //MARK: Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpPassCode()
    }

    //MARK: - SetUp

    func setUpPassCode() {
        passCode.delegate = self
        passCode.becomeFirstResponder()
    }

}

extension NewPassCodeViewController: PassCodeDelegate {
    func finishEnterCode(_ code: String) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ConfirmPasscodeViewController") as! ConfirmPasscodeViewController
        vc.newPassCode = code
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
