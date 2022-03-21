//
//  DetailSearchPresenter.swift
//  MeLiApp
//
//  Created by Ludin Jozabeth on 12-03-22.
//

import SwiftUI
import Combine

class DetailSearchPresenter: ObservableObject {
    @Published var interactor: DetailSearchInteractor
    var attributesItem = [String]()
    
    init(interactor: DetailSearchInteractor) {
        self.interactor = interactor
        
        interactor.item.attributes!.forEach { (attr) in
            let x = attr.name ?? ""
            attr.values!.forEach { (value) in
                let aux = value.name ?? " "
                let y = x + " " + String(describing: aux)
                attributesItem.append(y)
            }
        }
    }
}

