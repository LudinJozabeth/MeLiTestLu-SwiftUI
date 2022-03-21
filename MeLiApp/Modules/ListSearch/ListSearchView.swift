//
//  ListSearchView.swift
//  MeLiApp
//
//  Created by Ludin Jozabeth on 12-03-22.
//

import SwiftUI

struct ListSearchView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var presenter: ListSearchPresenter
    var allItems: [Result]
    var title: String
    var columns = Array(repeating: GridItem(.flexible()), count: 2)
    
    init(_ presenter: ListSearchPresenter, allItems: [Result], title: String){
        self.presenter = presenter
        self.allItems = allItems
        self.title = title
        APIServiceItems.shared.items = allItems
        UITableView.appearance().backgroundColor = .clear // For tableView
        UITableViewCell.appearance().backgroundColor = .clear // For tableViewCell
    }
    
    var btnBack : some View { Button(action: {
        self.presentationMode.wrappedValue.dismiss()
    }) {
        HStack {
            Image(systemName: "chevron.left") // set image here
                .aspectRatio(contentMode: .fit)
                .foregroundColor(.blue)
            Text("Volver")
        }
    }
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Image("fondo")
                    .resizable()
                    .aspectRatio(geometry.size, contentMode: .fill)
                    .edgesIgnoringSafeArea(.all)
                VStack{
                    List {
                        ForEach (self.allItems, id: \.id) { item in
                            self.presenter.linkBuilder(for: item, content: {
                                ListItemCell(item: item)
                                    .frame(height: 180)
                            })
                        }
                    }.navigationBarTitle(self.title, displayMode: .inline)
                        .navigationBarBackButtonHidden(true)
                        .navigationBarItems(leading: btnBack)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let model = DataModel()
        model.items = ModelCreatorHelper.createMockGetItemsResponse()
        let interactor = ListSearchInteractor(items: model.items)
        let presenter = ListSearchPresenter(interactor: interactor)
        
        return NavigationView {
            ListSearchView(presenter, allItems: model.items, title: "Ludin")
        }
    }
}
