//
//  HomeSearchInteractor.swift
//  MeLiApp
//
//  Created by Ludin Jozabeth on 12-03-22.
//

import Combine

class HomeSearchInteractor {
    var search: String = ""
    let model = DataModel()
    
    func getItems(search: String, model: DataModel, completion : @escaping () -> Void) {
        model.load(search: search, model: model, completion: {
            print("hacer luego de obtener data")
            completion()
        })
    }
    
}

