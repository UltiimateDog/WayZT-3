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
    let articles = Article.testArticles
    
    // MARK: - BODY
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.second)
            
            VStack(spacing: 0) {
                SearchBar(placeholderText: "Busca un articulo")
                    .padding(.bottom, 15)
                
                ScrollView(showsIndicators: false) {
                    ForEach(articles) { articulo in
                        NavigationLink {
                            ArticleDisplay(data: articulo)
                        } label: {
                            ArticlePreview(data: articulo)
                        }
                        .padding(.bottom, 5)
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
