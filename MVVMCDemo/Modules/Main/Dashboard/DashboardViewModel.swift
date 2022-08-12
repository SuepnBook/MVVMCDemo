//
//  DashboardViewModel.swift
//  MVVMCDemo
//
//  Created by Book on 2022/8/9.
//

import Foundation
import Combine

protocol DynamicViewModel {
    associatedtype Input
    associatedtype Output
    var input: Input { get }
    var output: Output { get }
}

final class DashboardViewModel {

//    let input: Input
//    let output: Output
//    private let nameSubject = CurrentValueSubject<String, Never>("")
//    private let validateSubject = PassthroughSubject<Void, Never>()
//    
//    init() {
//        let greeting = validateSubject
//            .map { name -> String? in
//                return "Hello \(name)!"
//            }
//            .prepend("")
//            .eraseToAnyPublisher()
//        self.output = Output(greeting: greeting)
//        self.input = Input(name: nameSubject,
//                           validate: validateSubject.asAnySubscriber())
//    }

}

extension DashboardViewModel {
    struct Input {
//         AnySubscriber 隱藏內部實現細節
        let name: AnySubscriber<String, Never>
        let validate: AnySubscriber<Void, Never>
    }
    struct Output {
        let greeting: AnyPublisher<String?, Never>
    }
}
