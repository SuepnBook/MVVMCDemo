//
//  AccountRepository.swift
//  MVVMCDemo
//
//  Created by Book on 2022/8/9.
//

import Foundation

class AccountRepository {
    static let shared: AccountRepository = .init()
}

// MARK: - Create
extension AccountRepository {

}

// MARK: - Read
extension AccountRepository {
    func getUserProfile() -> AccountDomainObject.Profile {
        let userID = LocalStorageClient.getUserID()
        let name = NetworkClient.getUserName(userID: userID)
        let age = NetworkClient.getUserAge(userID: userID)

        return .init(userID: userID, name: name, age: age)
    }
}

// MARK: - Update
extension AccountRepository {
    func updateUserName(name: String) {

    }
}

// MARK: - Delete
extension AccountRepository {
    func deleteUser(userID: String) {

    }
}
