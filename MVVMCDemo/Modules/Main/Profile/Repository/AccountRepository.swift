//
//  AccountRepository.swift
//  MVVMCDemo
//
//  Created by Book on 2022/8/9.
//

import Foundation

class AccountRepository {
    static let shared: AccountRepository = .init()

    private let network: NetworkClient

    private var profile: AccountDomainObject.Profile?

    init(network: NetworkClient = .init()) {
        self.network = network
    }
}

// MARK: - Create
extension AccountRepository {

}

// MARK: - Read
extension AccountRepository {
    func getUserProfile() -> AccountDomainObject.Profile {
        if let profile = profile {

            return profile

        } else {

            let userID = LocalStorageClient.getUserID()

            let name = network.getUserName(userID: userID)

            let age = network.getUserAge(userID: userID)

            let result: AccountDomainObject.Profile = .init(userID: userID, name: name, age: age)

            self.profile = result

            return result
        }
    }
}

// MARK: - Update
extension AccountRepository {
    func updateProfile () {
        let userID = LocalStorageClient.getUserID()

        let name = network.getUserName(userID: userID)
        let age = network.getUserAge(userID: userID)

        self.profile =  .init(userID: userID, name: name, age: age)
    }
    func updateUserName(name: String) {

    }
}

// MARK: - Delete
extension AccountRepository {
    func deleteUser(userID: String) {

    }
}
