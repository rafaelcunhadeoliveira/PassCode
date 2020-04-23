//
//  PassCodeBullet.swift
//  PassCodeMindGeek
//
//  Created by Rafael Cunha de Oliveira on 2020-04-21.
//  Copyright © 2020 Rafael Cunha de Oliveira. All rights reserved.
//

import UIKit

class PassCodeBullet: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        setLayout()
    }

    func setLayout() {
        backgroundColor = UIColor.lightGray.withAlphaComponent(0.1)
        layer.cornerRadius = bounds.width / 2
        layer.borderWidth = 2.0
        layer.borderColor = UIColor.black.withAlphaComponent(0.3).cgColor
    }

    func select(_ isSelected: Bool) {
        backgroundColor = isSelected ? UIColor.black.withAlphaComponent(0.7) : UIColor.lightGray.withAlphaComponent(0.1)
    }
}
