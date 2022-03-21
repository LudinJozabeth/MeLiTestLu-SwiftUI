
//
//  HomeSearchView.swift
//  MeLiApp
//
//  Created by Ludin Jozabeth on 11-03-22.
//

import SwiftUI

struct ErrorInfo: Identifiable {
    var id: Int
    let title: String
    let description: String
}

struct HomeSearchView: View {
    @State var text: String = ""
    @ObservedObject var presenter: HomeSearchPresenter
    @State var haveItems = false
    
    @FocusState private var isTextFieldFocused: Bool
    @State private var isEditing = false
    @State private var isActive = false
    
    @State private var error: ErrorInfo?
    
    var body: some View {
        
        NavigationView {
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
                        
                        
                        HStack {
                            TextField("¿Qué buscas hoy?", text: $text, onEditingChanged: {
                                self.isEditing = $0
                                presenter.goSearch(searchText: text, completion: { })
                                haveItems = presenter.interactor.model.items.count > 0
                            }, onCommit: {
                                presenter.goSearch(searchText: text, completion: {
                                    if presenter.interactor.model.items.count > 0 {
                                        haveItems = presenter.interactor.model.items.count > 0
                                        _ = presenter.router.makeListView(for: presenter.interactor.model.items, title: text)
                                    }
                                    print(DataModel.shared.items.count)
                                })
                            })
                            .padding(10)
                            .padding(.horizontal, 25)
                            .background(Color(.systemGray6))
                            // .foregroundColor(Color("subfont"))
                            .cornerRadius(8)
                            .overlay(
                                HStack {
                                    Image(systemName: "magnifyingglass")
                                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                        .padding(.leading, 15)
                                    
                                    if isEditing {
                                        Button(action: {
                                            self.text = ""
                                        }){
                                            Image(systemName: "multiply.circle.fill")
                                                .foregroundColor(.gray)
                                                .padding(.trailing, 8)
                                        }
                                    }
                                }
                            ).onTapGesture {
                                self.isEditing = true
                            }
                            .focused($isTextFieldFocused)
                            .onChange(of: isTextFieldFocused) { isFocused in
                                if !isFocused {
                                    presenter.goSearch(searchText: text, completion: {
                                        if presenter.interactor.model.items.count > 0 {
                                            _ = presenter.router.makeListView(for: presenter.interactor.model.items, title: text)
                                        }
                                    })
                                }
                                haveItems = presenter.interactor.model.items.count > 0
                            }
                            
                            if isEditing {
                                Button(action: {
                                    self.isEditing = false
                                    self.text = ""
                                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                                }){
                                    Text("Cancelar")
                                }
                                .padding(.trailing, 10)
                                .transition(.move(edge: .trailing))
                            }
                            
                        }.padding(.horizontal, 20)
                            .contentShape(Rectangle())
                        Button(action: {
                            presenter.goSearch(searchText: text, completion: {
                                if presenter.interactor.model.items.count > 0 {
                                    haveItems = true
                                    error = nil
                                } else {
                                    haveItems = false
                                    error = ErrorInfo(id: 3, title: "Ooopsss", description: "Lo sentimos, no encontramos resultados para tu búsqueda")
                                }
                            })
                        }) {
                            Text("Buscar!")
                        }.padding(12)
                            .background(Color(UIColor.systemBlue))
                            .foregroundColor(.white)
                            .cornerRadius(12)
                        
                        Spacer()
                        
                        NavigationLink(destination: presenter.router.makeListView(for: presenter.interactor.model.items, title: text), isActive: $haveItems) { }
                        
                        
                    }.alert(item: $error, content: { error in // 5
                        Alert(title: Text(error.title),
                              message: Text(error.description), dismissButton: .cancel())
                    } )
                }
            }
        }
    }
}

struct HomeSearchView_Previews: PreviewProvider {
    static var previews: some View {
        HomeSearchView(presenter: HomeSearchPresenter(interactor: HomeSearchInteractor()))
    }
}

