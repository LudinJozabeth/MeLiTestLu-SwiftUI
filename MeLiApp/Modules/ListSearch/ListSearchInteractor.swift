//
//  ListSearchInteractor.swift
//  MeLiApp
//
//  Created by Ludin Jozabeth on 12-03-22.
//

import SwiftUI
import Combine

class ListSearchInteractor {
    var items: [Result]?
    var model: DataModel
    
    init (items: [Result]?) {
        self.items = items
        self.model = DataModel.shared
    }
}
