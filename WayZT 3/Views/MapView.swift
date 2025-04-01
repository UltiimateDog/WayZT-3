//
//  MapView.swift
//  Waste Manager
//
//  Created by Ultiimate Dog on 28/02/24.
//

import SwiftUI

struct MapView: View {
    let dWidth: Double
    let dHeight: Double
    let colorP = ColorPalette()
    @State var wish = false
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.white)
            Rectangle()
                .fill(colorP.c5.opacity(0.4))
            EmitterViewIcon(wish: $wish)
            
            VStack(spacing: 10) {
                SearchBar(placeholderText: "Busca un servicio")
                    .padding(.bottom, 10)
                RoundedRectangle(cornerRadius: dWidth * 0.06)
                    .fill(colorP.c1)
                    .frame(height: dHeight*0.35)
                    .overlay {
                        MapProgress(dWidth: dWidth, dHeight: dHeight)
                    }
                HStack(spacing: 10) {
                    NavigationLink {
                        RecycleMap()
                    } label: {
                        TypeWasteButton(dWidth: dWidth, dHeight: dHeight, i: 0)
                    }
                    NavigationLink {
                        OrganicMap()
                    } label: {
                        TypeWasteButton(dWidth: dWidth, dHeight: dHeight, i: 1)
                    }
                }
                HStack(spacing: 10) {
                    NavigationLink {
                        GlassMap()
                    } label: {
                        TypeWasteButton(dWidth: dWidth, dHeight: dHeight, i: 2)
                    }
                    NavigationLink {
                        ElectronicsMap()
                    } label: {
                        TypeWasteButton(dWidth: dWidth, dHeight: dHeight, i: 3)
                    }
                }
            }
            .padding(.horizontal, 10)
            .padding(.bottom, dWidth / 5 + 10)
        }
    }
}

#Preview {
    MapView(dWidth: 300, dHeight: 700)
}
