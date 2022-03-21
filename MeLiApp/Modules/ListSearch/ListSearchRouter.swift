//
//  ListSearchRouter.swift
//  MeLiApp
//
//  Created by Ludin Jozabeth on 12-03-22.
//

import SwiftUI

class ListSearchRouter {
    func makeDetailView(for item: Result) -> some View {
        let presenter = DetailSearchPresenter(
            interactor: DetailSearchInteractor(
                item: item))
        return DetailSearchView(presenter: presenter)
    }
}

