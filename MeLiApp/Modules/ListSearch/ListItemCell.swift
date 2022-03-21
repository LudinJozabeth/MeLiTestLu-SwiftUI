//
//  ListItemCell.swift
//  MeLiApp
//
//  Created by Ludin Jozabeth on 12-03-22.
//

import SwiftUI
import Combine

struct ListItemCell: View {
    var item: Result
    
    @State private var images: [UIImage] = []
    
    var body: some View {
            GeometryReader { geometry in
                ZStack(alignment: .bottomLeading) {
                    AsyncImage(url: URL(string: item.thumbnail!)) { image in
                        image.resizable()
                    } placeholder: {
                        Color.cyan
                    }
                    .frame(height: 150)
                    BlurView()
                        .frame(width: geometry.size.width, height: 55)
                    HStack {
                        VStack (alignment: .leading){
                            Text(item.title ?? "Resultados de tu búsqueda")
                                .font(.system(size: 12))
                                .fontWeight(.bold)
                                .foregroundColor(.black)
                        }
                    }
                }
                ZStack(alignment: .topTrailing) {
                    HStack {
                        Text("$ \(String(item.price ?? 0.0))")
                            .font(.headline)
                            .fontWeight(.semibold)
                        Spacer()
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.cyan)
                            .frame(width: 45, height: 45)
                            .overlay(
                                Image(systemName: "cart")
                                    .resizable()
                                    .frame(width: 20, height: 20, alignment: .center)
                                    .foregroundColor(Color(.white)))
                            .shadow(color: Color(.gray).opacity(0.05), radius: 8, x:0 , y: 5)
                    }
                }
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 10)
            .clipShape(RoundedRectangle(cornerRadius: 15))
        }
}


#if DEBUG
struct ListItemCell_Previews: PreviewProvider {
    static var previews: some View {
        let model = DataModel()
        model.items = ModelCreatorHelper.createMockGetItemsResponse()
        let item = model.items[0]
        return ListItemCell(item: item)
            .frame(height: 120)
            .environmentObject(model)
    }
}
#endif

struct BlurView: UIViewRepresentable {
    func makeUIView(context: UIViewRepresentableContext<BlurView>) -> UIView {
        let view = UIView()
        view.backgroundColor = .clear
        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterial)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(blurView, at: 0)
        NSLayoutConstraint.activate([
            blurView.heightAnchor.constraint(equalTo: view.heightAnchor),
            blurView.widthAnchor.constraint(equalTo: view.widthAnchor),
        ])
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<BlurView>) {
    }
}
