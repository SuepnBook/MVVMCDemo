//
//  RealtimeDatabaseRepository.swift
//  Shared
//
//  Created by Book on 2022/7/8.
//

import Foundation
import FirebaseCore
import FirebaseDatabase
import Combine
import UIKit

class RealtimeDatabase {
    
    static let shared:RealtimeDatabase = RealtimeDatabase()
    
    private lazy var ref: DatabaseReference = Database.database().reference()
    
    @Published var root:RealTimeDatabaseDomainObject.Root = .init(pasteBoard: [])
    
    init() {
        Database.database().isPersistenceEnabled = true
    }
    
    func setupObserve() {
        ref
            .child("v1")
            .observe(.value) { [weak self] (snapshot) in
                guard let self = self else { return }
                do {
                    let root = try JSONDecoder().decode(RealTimeDatabaseDomainObject.Root.self,
                                             from: snapshot.valueToJSON)
                    self.root = root
                } catch {
                    self.root = .init(pasteBoard: [])
                    print(error)
                }
            }
    }
}

//MARK: - Create
extension RealtimeDatabase {
    func createPasteData(data:RealTimeDatabaseDomainObject.Root.PasteData) {
        var root = root
        root.pasteBoard.insert(data, at: 0)
        updateRoot(root: root)
    }
}

//MARK: - Read
extension RealtimeDatabase {
    func getPasteData() -> [RealTimeDatabaseDomainObject.Root.PasteData] {
        return root.pasteBoard
    }
}

//MARK: - Update
extension RealtimeDatabase {
    func updatePasteData(index:Int,data:RealTimeDatabaseDomainObject.Root.PasteData) {
        var root = root
        root.pasteBoard[index] = data
        updateRoot(root: root)
    }
    
    private func updateRoot(root:RealTimeDatabaseDomainObject.Root) {
        do {
            let data = try JSONEncoder().encode(root)
            let json = try JSONSerialization.jsonObject(with: data)
            ref.child("v1")
                .setValue(json)
        } catch {
            print(error)
        }
    }
}

//MARK: - Delete
extension RealtimeDatabase {
    func deletePasteData(index:Int) {
        var root = root
        root.pasteBoard.remove(at: index)
        updateRoot(root: root)
    }
}
