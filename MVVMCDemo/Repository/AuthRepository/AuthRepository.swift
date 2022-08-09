//
//  AuthRepository.swift
//  MVVMCDemo
//
//  Created by Book on 2022/8/9.
//

import Foundation

class AuthRepository {
    static let shared:AuthRepository = .init()
}

//MARK: - Create
extension AuthRepository {
    
}

//MARK: - Read
extension AuthRepository {
    func getAuthStatus() -> AuthDomainObject.AuthStatus {
        return .logout
    }
    
    func isNeedBiometricsCheck() -> Bool {
        return true
    }
    
    func checkLogin(userName:String,password:String) -> Bool {
        return true
    }
}

//MARK: - Update
extension AuthRepository {
    
}

//MARK: - Delete
extension AuthRepository {
    
}
