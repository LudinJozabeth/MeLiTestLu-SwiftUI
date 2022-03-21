//
//  DetailSearchInteractor.swift
//  MeLiApp
//
//  Created by Ludin Jozabeth on 12-03-22.
//

import Combine

class DetailSearchInteractor {
    @Published var item: Result
    
    init (item: Result) {
        self.item = item
    }
}
