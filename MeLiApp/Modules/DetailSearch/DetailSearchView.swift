//
//  DetailSearchView.swift
//  MeLiApp
//
//  Created by Ludin Jozabeth on 12-03-22.
//

import SwiftUI

struct DetailSearchView: View {
    @ObservedObject var presenter: DetailSearchPresenter
    
    var attributesItem = [String]()
    
    var body: some View {
        Form {
            Section(header: Text(presenter.interactor.item.title ?? "Detalles").font(.title)) {
                AsyncImage(url: URL(string: presenter.interactor.item.thumbnail!)) { image in
                    image.resizable()
                } placeholder: {
                    Color.cyan
                }
                .frame(height: 150)
                
                Text(String(presenter.interactor.item.price ?? 0.0))
                    .font(.headline)
                
                VStack {
                    
                    Text("Valoración: \(  String(presenter.interactor.item.installments?.rate ?? 0))" ).font(.headline)
                    Text("Disponibles: \(  String(presenter.interactor.item.installments?.quantity ?? 0))" ).font(.headline)
                    
                    List(presenter.attributesItem, id: \.self) { string in
                        Text(string)
                    }
                }
            }
        }.background(Image("fondo")
            .resizable()
//            .aspectRatio(geometry.size, contentMode: .fill)
            .edgesIgnoringSafeArea(.all))
    }
}

struct TripDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let model = DataModel()
        model.items = ModelCreatorHelper.createMockGetItemsResponse()
        
        let presenter = DetailSearchPresenter(
            interactor:
                DetailSearchInteractor(
                    item: model.items [0]))
        return NavigationView {
            DetailSearchView(presenter: presenter)
        }
    }
}

