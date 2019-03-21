//
//  DetailImageDetailImageViewModel.swift
//  project
//
//  Created by Zakhar Babkin on 08/12/2018.
//  Copyright © 2018 Zachary Babkin. All rights reserved.
//

import Foundation

final class DetailImageViewModel: DetailImageViewModelInput, Routable {
    weak var view: DetailImageViewModelOutput?
    var router: DetailImageRouter?
    
    var image: Data

    enum Routes {
    }
    
    init(image: Data) {
        self.image = image
    }
    
    func close() {
        router?.close()
    }
}
