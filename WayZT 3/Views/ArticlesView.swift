//
//  ArticlesView.swift
//  Waste Manager
//
//  Created by Ultiimate Dog on 28/02/24.
//

import SwiftUI

struct ArticlesView: View {
    // MARK: - ATTRIBUTES
    var modelData: ModelData = .shared
    @State var index = -1
    let colorP = ColorPalette()
    let articulos = [testArticles().A6, testArticles().A2, testArticles().A3, testArticles().A5, testArticles().A4, testArticles().A1]
    @State var wish = false
    
    // MARK: - BODY
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.white)
            Rectangle()
                .fill(colorP.c5.opacity(0.6))
            
            EmitterViewIcon(wish: $wish)

            VStack(spacing: 0) {
                SearchBar(placeholderText: "Busca un articulo")
                    .padding(.bottom, 15)
                
                ScrollView(showsIndicators: false) {
                    ForEach(articulos) { articulo in
                        NavigationLink {
                            ArticleDisplay(data: articulo)
                        } label: {
                            ArticlePreview(data: articulo)
                        }
                    }
                }
                .clipShape(RoundedRectangle(cornerRadius: 20))
            }
            .padding(.horizontal, 10)
            .padding(.bottom, 50)
        }//: ZSTACK
    }
}

#Preview {
    ArticlesView()
}
