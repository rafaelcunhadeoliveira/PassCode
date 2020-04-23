//
//  PassCode.swift
//  PassCodeMindGeek
//
//  Created by Rafael Cunha de Oliveira on 2020-04-21.
//  Copyright © 2020 Rafael Cunha de Oliveira. All rights reserved.
//

import UIKit

protocol PassCodeDelegate: AnyObject {
    func finishEnterCode(_ code: String)
}

class PassCode: UIView {

    @IBOutlet weak var bulletOne: PassCodeBullet!
    @IBOutlet weak var bulletTwo: PassCodeBullet!
    @IBOutlet weak var bulletThree: PassCodeBullet!
    @IBOutlet weak var bulletFour: PassCodeBullet!
    @IBOutlet var passCodeView: UIView!

    var code = "" {
        didSet {
            select()
        }
    }
    var max = 4
    weak var delegate: PassCodeDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed("PassCode", owner: self, options: nil)
        passCodeView.frame = self.bounds
        passCodeView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        addSubview(passCodeView)
    }

    func select() {
        bulletOne.select(code.count > 0)
        bulletTwo.select(code.count > 1)
        bulletThree.select(code.count > 2)
        bulletFour.select(code.count > 3)
    }

}

extension PassCode {
    override var canBecomeFirstResponder: Bool { return true }
}

extension PassCode: UIKeyInput {
    var hasText: Bool {
        return code.count > 0
    }
    
    func insertText(_ text: String) {
        if text.isAlphanumeric {
            code.append(contentsOf: text)
            if code.count == max {
                delegate?.finishEnterCode(code)
                return
            }
        }
    }
    
    func deleteBackward() {
        if hasText {
            code.removeLast()
        }
    }
}
