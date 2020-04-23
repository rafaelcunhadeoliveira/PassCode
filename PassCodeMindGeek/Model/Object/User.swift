//
//  User.swift
//  PassCodeMindGeek
//
//  Created by Rafael Cunha de Oliveira on 2020-04-22.
//  Copyright © 2020 Rafael Cunha de Oliveira. All rights reserved.
//

import Foundation

class User {
    var code: String
    var isLogged: Bool
    var blocked: Date?

    static var sharedInstace: User = User()

    init(code: String = "", isLogged: Bool = false, blocked: Date? = nil) {
        self.code = code
        self.isLogged = isLogged
        self.blocked = blocked
    }
}
