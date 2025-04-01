//
//  ArticlePreview.swift
//  Waste Manager
//
//  Created by Ultiimate Dog on 03/03/24.
//

import SwiftUI

struct ArticlePreview: View {
    var modelData: ModelData = .shared
    let colorP = ColorPalette()
    let data: Articulo
    
    var body: some View {
        RoundedRectangle(cornerRadius: 5)
            .fill(colorP.c1)
            .frame(height: 70)
            .overlay {
                HStack {
                    data.previewImage
                        .resizable()
                        .scaledToFill()
                        .frame(width: 40)
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                    VStack(alignment: .leading, spacing: 0) {
                        Text(data.title)
                            .font(.headline)
                            .bold()
                            .foregroundStyle(Color.black)
                            .multilineTextAlignment(.leading)
                        Spacer()
                        HStack {
                            data.authorPicture
                                .resizable()
                                .scaledToFit()
                                .frame(width: 5)
                                .clipShape(Circle())
                            Text(data.author)
                                .font(.caption)
                                .italic()
                                .lineLimit(1)
                                .foregroundStyle(Color.black)
                            Spacer()
                            Text(data.date, style: .date)
                                .font(.caption)
                                .italic()
                                .lineLimit(1)
                                .foregroundStyle(Color.black)
                        }
                    }
                }
                .padding(.all, 10)
            }
    }
}

#Preview {
    ArticlePreview(data: testArticles().A1)
}
