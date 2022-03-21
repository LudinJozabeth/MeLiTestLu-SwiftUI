//
//  HomeSearchPresenter.swift
//  MeLiApp
//
//  Created by Ludin Jozabeth on 12-03-22.
//

import SwiftUI
import Combine

class HomeSearchPresenter: ObservableObject {
    let interactor: HomeSearchInteractor
    let router = HomeSearchRouter()
    var showAlert: Bool = false

    @Published var items: [Result] = []
    private var cancellables = Set<AnyCancellable>()
    
    init(interactor: HomeSearchInteractor) {
        self.interactor = interactor
        interactor.model.$items
          .assign(to: \.items, on: self)
          .store(in: &cancellables)
    }
    //Model
    func goSearch(searchText: String, completion : @escaping () -> Void) {
        interactor.getItems(search: searchText, model: interactor.model, completion:   {
            completion()
            print("--> " , self.interactor.model.items.count)
            self.showAlert = !(self.interactor.model.items.count > 0)
        })
    }
    
    //Router
    func linkBuilder<Content: View>( for items: [Result], title: String,
                                     @ViewBuilder content: () -> Content) -> some View {
        NavigationLink(destination: router.makeListView(
            for: items, title: title)) {
                content()
            }
    }
}

