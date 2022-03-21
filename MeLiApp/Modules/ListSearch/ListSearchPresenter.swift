//
//  ListSearchPresenter.swift
//  MeLiApp
//
//  Created by Ludin Jozabeth on 12-03-22.
//

import SwiftUI
import Combine

class ListSearchPresenter: ObservableObject {
    let interactor: ListSearchInteractor
    let router = ListSearchRouter()
    
    init(interactor: ListSearchInteractor) {
        self.interactor = interactor
        self.interactor.items = interactor.model.items
    }
   
    //Router
    func linkBuilder<Content: View>( for item: Result,
                                     @ViewBuilder content: () -> Content) -> some View {
        NavigationLink(destination: router.makeDetailView(
            for: item)) {
                content()
            }
    }
}
