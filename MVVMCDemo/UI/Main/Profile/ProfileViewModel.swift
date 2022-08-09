//
//  ProfileViewModel.swift
//  MVVMCDemo
//
//  Created by Book on 2022/8/9.
//

import Foundation

protocol ProfileViewModelOutput: AnyObject {
    func profileViewModel(_ vm:ProfileViewModel,
                          update profile:AccountDomainObject.Profile)
}

class ProfileViewModel {
    
    weak var output:ProfileViewModelOutput?
    
    private let accountRepository:AccountRepository
    
    init(accountRepository:AccountRepository = .init()) {
        self.accountRepository = accountRepository
    }
    
    func viewDidLoad() {
        let profile = accountRepository.getUserProfile()
        output?.profileViewModel(self, update: profile)
    }
}
