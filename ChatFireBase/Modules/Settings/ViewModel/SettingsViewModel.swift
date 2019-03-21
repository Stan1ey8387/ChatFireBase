//
//  SettingsSettingsViewModel.swift
//  project
//
//  Created by Zakhar Babkin on 06/12/2018.
//  Copyright © 2018 Zachary Babkin. All rights reserved.
//

import Firebase

final class SettingsViewModel: SettingsViewModelInput, Routable {
    weak var view: SettingsViewModelOutput?
    var router: SettingsRouter?

    enum Routes {
        case logout
    }
    
    func logout() {
        do {
            try Auth.auth().signOut()
            router?.route(to: .logout)
        } catch {
            print("Error logout")
        }
    }
}
