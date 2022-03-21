//
//  HomeSearchRouter.swift
//  MeLiApp
//
//  Created by Ludin Jozabeth on 12-03-22.
//

import SwiftUI

class HomeSearchRouter {
    func makeListView(for items: [Result], title: String) -> some View {
        let presenter = ListSearchPresenter(interactor:
            ListSearchInteractor(items: items))
        return ListSearchView(presenter, allItems: items, title: title)
    }
}
