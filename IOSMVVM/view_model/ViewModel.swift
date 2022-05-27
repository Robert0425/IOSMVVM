//
//  ViewModel.swift
//  IOSMVVM
//
//  Created by Robert_Tseng on 2022/5/24.
//

class ViewModel {
    func userInput(name: String, completionHandler: (User) -> Void) {
        let user = User(name: name)
        completionHandler(user)
    }
}
