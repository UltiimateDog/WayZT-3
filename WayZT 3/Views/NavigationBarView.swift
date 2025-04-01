//
//  NavigationBar.swift
//  Waste Manager
//
//  Created by Ultiimate Dog on 28/02/24.
//

import SwiftUI

struct NavigationBarView: View {
    @State var currentTab: Tab = .Camera
    @State var changeProfPic = false
    let colorP = ColorPalette()
    
    // Hide native bar
    init () {
        UITabBar.appearance().isHidden = true
    }
        
    var body: some View {
        GeometryReader { proxy in
            let dHeight = proxy.size.height
            let dWidth = proxy.size.width
            
            NavigationStack {
                TabView(selection: $currentTab) {
                    CameraView()
                        .tag(Tab.Camera)
                        .onAppear {
                            changeProfPic = false
                        }
                    
                    ArticlesView()
                        .tag(Tab.Articles)
                        .onAppear {
                            changeProfPic = false
                        }
                    
                    ProfileView(dWidth: dWidth, dHeight: dHeight, changePic: $changeProfPic)
                        .ignoresSafeArea()
                        .tag(Tab.Profile)
                    
                    MapView()
                        .tag(Tab.Maps)
                        .onAppear {
                            changeProfPic = false
                        }
                }
                .overlay(alignment: .bottom) {
                    HStack(spacing: 0) {
                        ForEach (Tab.allCases, id: \.rawValue) { tab in
                            TabButton(tab: tab, dWidth: dWidth)
                        }
                        .background(colorP.c6)
                        .padding(.bottom, 5)
                    }
                }
                .ignoresSafeArea()
            }
        }
    }
    
    func TabButton(tab: Tab, dWidth: Double) -> some View {
        Button {
            withAnimation(.spring()) {
                currentTab = tab
            }
        } label: {
            ZStack {
                Circle()
                    .fill(currentTab == tab ? LinearGradient(colors: [colorP.c2, colorP.c6], startPoint: .top, endPoint: .bottom) : LinearGradient(colors: [Color.clear], startPoint: .top, endPoint: .bottom))
                    .offset(y: currentTab == tab ? -35 : 0)
                    .frame(height: dWidth / 5)
                Image(systemName: currentTab == tab ? tab.rawValue + ".fill": tab.rawValue)
                    .resizable()
                    .scaledToFit()
                    .frame(width: tab == Tab.Articles || tab == Tab.Maps ? 25 : 27)
                    .frame(maxWidth: .infinity)
                    .foregroundStyle(colorP.c1)
                    .contentShape(Rectangle())
                    .offset(y: currentTab == tab ? -35 : 0)
            }
        }
    }
}

// Tabbar enum
enum Tab: String, CaseIterable {
    case Profile = "person"
    case Camera = "camera"
    case Maps = "map"
    case Articles = "book.pages"
    //case New = "rectangle.portrait.and.arrow.right"
    
    var tabName: String {
        switch self {
        case .Profile:
            return "Profile"
        case .Camera:
            return "Camera"
        case .Maps:
            return "Map"
        case .Articles:
            return "Articles"
        //case .New:
            //return "New"
        }
    }
}

#Preview {
    NavigationBarView()
}
