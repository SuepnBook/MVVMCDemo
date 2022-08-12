//
//  AuthDomainObject.swift
//  MVVMCDemo
//
//  Created by Book on 2022/8/9.
//

import Foundation

struct AuthDomainObject {

    enum AuthStatus {
        case login
        case logout
        case sessionExpire
    }
}
