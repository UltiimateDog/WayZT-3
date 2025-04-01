//
//  MapView.swift
//  Waste Manager
//
//  Created by Ultiimate Dog on 28/02/24.
//

import SwiftUI

struct MapView: View {
    let colorP = ColorPalette()
    let dWidth: Double = 300
    let dHeight: Double = 300
   
    // MARK: - BODY
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.white)
            Rectangle()
                .fill(colorP.c5.opacity(0.4))
            
            VStack(spacing: 10) {
                SearchBar(placeholderText: "Busca un servicio")
                    .padding(.bottom, 10)
                
            
                MapProgress()
                    
                
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
    MapView()
}
