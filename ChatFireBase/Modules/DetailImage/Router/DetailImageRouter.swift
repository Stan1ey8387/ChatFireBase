//
//  DetailImageDetailImageRouter.swift
//  project
//
//  Created by Zakhar Babkin on 08/12/2018.
//  Copyright © 2018 Zachary Babkin. All rights reserved.
//

import UIKit

class DetailImageRouter: Router {
    typealias RoutableType = DetailImageViewModel
    typealias Context = UIViewController

    weak var context: Context?

    func route(to route: DetailImageViewModel.Routes) {
        switch route {
        }
    }
}
