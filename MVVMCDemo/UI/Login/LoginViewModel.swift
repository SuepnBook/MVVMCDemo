//
//  LoginViewModel.swift
//  MVVMCDemo
//
//  Created by Book on 2022/8/9.
//

import Foundation

protocol LoginViewModelOutput:AnyObject {
    func loginViewModel(_ vm:LoginViewModel, with isLoginSuccess:Bool)
}

class LoginViewModel {
    
    weak var output:LoginViewModelOutput?
    
    private let authRepository:AuthRepository
    
    init(authRepository:AuthRepository = .shared) {
        self.authRepository = authRepository
    }
    
    func checkLogin(userName:String,password:String)  {
        let isValid = authRepository.checkLogin(userName: userName,
                                                password: password)
        output?.loginViewModel(self, with: isValid)
    }
}


