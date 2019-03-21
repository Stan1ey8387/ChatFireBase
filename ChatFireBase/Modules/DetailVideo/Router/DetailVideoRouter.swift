//
//  DetailVideoDetailVideoRouter.swift
//  project
//
//  Created by Zakhar Babkin on 12/12/2018.
//  Copyright © 2018 Zachary Babkin. All rights reserved.
//

import UIKit

class DetailVideoRouter: Router {
    typealias RoutableType = DetailVideoViewModel
    typealias Context = UIViewController

    weak var context: Context?

    func route(to route: DetailVideoViewModel.Routes) {
        switch route {
        }
    }
}
