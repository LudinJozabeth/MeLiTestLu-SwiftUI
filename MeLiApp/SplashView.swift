//
//  SplashView.swift
//  MeLiApp
//
//  Created by Ludin Jozabeth on 12-03-22.
//

import SwiftUI

struct SplashView: View {
    @State var isActive:Bool = false
    @EnvironmentObject var model: DataModel
    
    var body: some View {
        VStack {
            if self.isActive {
                HomeSearchView(presenter: HomeSearchPresenter(interactor: HomeSearchInteractor()))
            } else {
                GeometryReader { geometry in
                    ZStack {
                        Image("fondo")
                            .resizable()
                            .aspectRatio(geometry.size, contentMode: .fill)
                            .edgesIgnoringSafeArea(.all)
                        VStack {
                            Image("meli")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 250.0, height: 250.0, alignment: .center)
                                .clipped()
                        }
                    }
                }
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                withAnimation {
                    self.isActive = true
                }
            }
        }
    }
}
