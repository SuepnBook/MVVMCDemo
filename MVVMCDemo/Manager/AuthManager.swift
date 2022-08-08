//
//  AuthManager.swift
//  MVVMCDemo
//
//  Created by Book on 2022/8/9.
//

import Foundation

enum AuthStatus {
    case login
    case logout
    case sessionExpire
}

class AuthMangager {
    
    static let shared:AuthMangager = .init()
    
    func getAuthStatus() -> AuthStatus {
        return .logout
    }
}
