//
//  ProfileView.swift
//  Waste Manager
//
//  Created by Ultiimate Dog on 28/02/24.
//

import SwiftUI
import PhotosUI

struct ProfileView: View {
    @Environment(\.safeAreaInsets) private var safeAreaInsets
    var modelData: ModelData = .shared
    let dWidth: Double
    let dHeight: Double
    let colorP = ColorPalette()
    
    @State private var anim = false
    @State private var showFull = false
    @State var wish = false
    @Binding var changePic: Bool
    
    @State private var avatarItem: PhotosPickerItem?

    var body: some View {
        ZStack(alignment: .top) {
            Rectangle()
                .fill(Color.white)
            Rectangle()
                .fill(colorP.c5.opacity(0.3))
            EmitterViewIcon(wish: $wish)
                .blur(radius: changePic ? 2 : 0)
            topBack()
                .blur(radius: changePic ? 2 : 0)
            notiButton()
                .blur(radius: changePic ? 2 : 0)
            VStack {
                profilePic()
                nameAShare()
                    .blur(radius: changePic ? 2 : 0)
                profileGidgets()
                    .blur(radius: changePic ? 2 : 0)
                seeFullButton()
                    .blur(radius: changePic ? 2 : 0)
            }
            .padding(safeAreaInsets)
            .padding(.horizontal, 10)
            .padding(.bottom, dWidth / 5 + 10)
        }
    }
    
    func profilePic() -> some View {
        ZStack {
            Circle()
                .fill(
                    RadialGradient(colors: [colorP.c2, Color.clear], center: .center, startRadius: 50, endRadius: 75)
                )
                .frame(width: dWidth * 0.45)
                .scaleEffect(x: anim ? 1.65 : 1, y: anim ? 1.65 : 1)
                .onAppear {
                    withAnimation(.easeInOut(duration: 3).repeatForever(autoreverses: true)) {
                        anim.toggle()
                    }
                }
            Image("appLogo")
                .resizable()
                .scaledToFit()
                .frame(width: dWidth * 0.59)
                .offset(x: -1)
                .rotationEffect(.degrees(anim ? 45 : 0))
                .scaleEffect(x: anim ? 1 : 0.99, y: anim ? 1 : 0.99)
                .blur(radius: changePic ? 2 : 0)
            Image(uiImage: modelData.profile.profilePic)
                .resizable()
                .scaledToFill()
                .frame(width: dWidth * 0.45, height: dWidth * 0.45)
                .background()
                .clipShape(Circle())
                .scaleEffect(x: changePic ? 1.1 : 1, y: changePic ? 1.1 : 1)
                .onLongPressGesture(minimumDuration: 0.5) {
                    withAnimation() {
                        changePic = true
                    }
                } onPressingChanged: { a in
                    withAnimation() {
                        changePic = a
                    }
                }
                
        }
        .popover(isPresented: $changePic) {
            HStack {
                Spacer()
                PhotosPicker("Cambiar foto de perfil", selection: $avatarItem, matching: .images)
                    .presentationCompactAdaptation(.popover)
                Spacer()
            }
            .presentationCompactAdaptation(.popover)
            .onChange(of: avatarItem) {
                        Task {
                            if let loaded = try? await avatarItem?.loadTransferable(type: Data.self) {
                                modelData.profile.profilePic = UIImage(data: loaded) ?? modelData.profile.profilePic
                            } else {
                                print("Failed")
                            }
                        }
                    }
        }
    }
    
    func topBack() -> some View {
        Rectangle()
            .fill(
                LinearGradient(colors: [colorP.c5, colorP.c2, colorP.c3], startPoint: .topLeading, endPoint: .bottomTrailing)
            )
            .shadow(color: Color.green, radius: 12)
            .frame(height: safeAreaInsets.top + dWidth * 0.3)
    }
    
    func notiButton() -> some View {
        HStack {
            Button {
                //
            } label: {
                Image(systemName: "gear")
                    .resizable()
                    .scaledToFit()
                    .frame(width: dWidth * 0.082)
                    .foregroundStyle(colorP.c6)
            }
            Spacer()
            Button {
                //
            } label: {
                Image(systemName: "bell.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: dWidth * 0.06)
                    .foregroundStyle(colorP.c6)
            }
        }
        .padding(safeAreaInsets)
        .padding(.horizontal, 17)
        .padding(.bottom, dWidth / 5 + 10)
    }
    
    func profileGidgets() -> some View {
        HStack {
            VStack(spacing: 0) {
                Text("Has separado: ")
                    .font(.title3)
                    .foregroundStyle(colorP.c6)
                    .bold()
                RoundedRectangle(cornerRadius: dWidth * 0.06)
                    .fill(colorP.c2)
                    .frame(width: dWidth * 0.45, height: dWidth * 0.22)
                    .overlay {
                        VStack(spacing: 0) {
                            HStack {
                                Text(String(modelData.profile.hisWaste))
                                    .font(.title)
                                    .foregroundStyle(colorP.c6)
                                    .bold()
                                Image(systemName: "trash")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: dWidth * 0.05)
                                    .foregroundStyle(colorP.c6)
                            }
                            Text("Residuos")
                                .foregroundStyle(colorP.c6)
                                .bold()
                                .italic()
                        }
                }
            }
            VStack(spacing: 0) {
                Text("Durante: ")
                    .font(.title3)
                    .foregroundStyle(colorP.c6)
                    .bold()
                RoundedRectangle(cornerRadius: dWidth * 0.06)
                    .fill(colorP.c2)
                    .frame(width: dWidth * 0.45, height: dWidth * 0.22)
                    .overlay {
                        VStack(spacing: 0) {
                            HStack {
                                Text(String(modelData.profile.weekStreak))
                                    .font(.title)
                                    .foregroundStyle(colorP.c6)
                                    .bold()
                                Image(systemName: "flame")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: dWidth * 0.05)
                                    .foregroundStyle(colorP.c6)
                            }
                            Text("Semanas")
                                .foregroundStyle(colorP.c6)
                                .bold()
                                .italic()
                        }
                }
            }
        }
    }
    
    func seeFullButton() -> some View {
        RoundedRectangle(cornerRadius: dWidth * 0.06)
            .fill(colorP.c6)
            .frame(height: showFull ? .infinity : dHeight * 0.05)
            .overlay {
                ZStack {
                    if !showFull {
                        HStack {
                            Text("Ve tu progreso")
                                .font(.title2)
                                .foregroundStyle(colorP.c1)
                                .bold()
                            Image(systemName: "cellularbars")
                                .resizable()
                                .scaledToFit()
                                .frame(height: dWidth * 0.04)
                                .foregroundStyle(colorP.c1)
                        }
                    }
                    showStats()
                }
            }
            .onTapGesture {
                withAnimation() {
                    showFull.toggle()
                }
            }
            .padding(.bottom, 10)
    }
    
    func showStats() -> some View {
        VStack {
            Text("Tu progreso:")
                .font(.title2)
                .foregroundStyle(colorP.c1)
                .bold()
                .opacity(showFull ? 1 : 0)
                .offset(y: showFull ? 0 : dHeight * 0.05)
            Spacer()
            HStack {
                Text("Reciclable: ")
                    .font(.title2)
                    .foregroundStyle(colorP.c1)
                    .bold()
                Spacer()
                RoundedRectangle(cornerRadius: dWidth * 0.06)
                    .fill(colorP.c2)
                    .frame(width: dWidth * 0.5, height: dHeight * 0.05)
                    .overlay {
                        HStack {
                            Text(String(modelData.profile.hisRecW))
                                .font(.title)
                                .foregroundStyle(colorP.c6)
                                .bold()
                            Spacer()
                            Image(systemName: "waterbottle")
                                .resizable()
                                .scaledToFit()
                                .frame(width: dWidth * 0.035)
                                .foregroundStyle(colorP.c6)
                        }
                        .padding(.horizontal, dWidth * 0.12)
                    }
            }
            .opacity(showFull ? 1 : 0)
            Spacer()
            HStack {
                Text("Organica: ")
                    .font(.title2)
                    .foregroundStyle(colorP.c1)
                    .bold()
                Spacer()
                RoundedRectangle(cornerRadius: dWidth * 0.06)
                    .fill(colorP.c2)
                    .frame(width: dWidth * 0.5, height: dHeight * 0.05)
                    .overlay {
                        HStack {
                            Text(String(modelData.profile.hisOrgW))
                                .font(.title)
                                .foregroundStyle(colorP.c6)
                                .bold()
                            Spacer()
                            Image(systemName: "carrot")
                                .resizable()
                                .scaledToFit()
                                .frame(width: dWidth * 0.07)
                                .foregroundStyle(colorP.c6)
                                .offset(x: dWidth * 0.01)
                        }
                        .padding(.horizontal, dWidth * 0.12)
                    }
            }
            .offset(y: showFull ? 0 : -dHeight * 0.03)
            .opacity(showFull ? 1 : 0)
            Spacer()
            HStack {
                Text("Vidrio: ")
                    .font(.title2)
                    .foregroundStyle(colorP.c1)
                    .bold()
                Spacer()
                RoundedRectangle(cornerRadius: dWidth * 0.06)
                    .fill(colorP.c2)
                    .frame(width: dWidth * 0.5, height: dHeight * 0.05)
                    .overlay {
                        HStack {
                            Text(String(modelData.profile.hisGlassW))
                                .font(.title)
                                .foregroundStyle(colorP.c6)
                                .bold()
                            Spacer()
                            Image(systemName: "wineglass")
                                .resizable()
                                .scaledToFit()
                                .frame(width: dWidth * 0.04)
                                .foregroundStyle(colorP.c6)
                        }
                        .padding(.horizontal, dWidth * 0.12)
                    }
            }
            .offset(y: showFull ? 0 : -dHeight * 0.06)
            .opacity(showFull ? 1 : 0)
            Spacer()
            HStack {
                Text("Electronicos: ")
                    .font(.title2)
                    .foregroundStyle(colorP.c1)
                    .bold()
                Spacer()
                RoundedRectangle(cornerRadius: dWidth * 0.06)
                    .fill(colorP.c2)
                    .frame(width: dWidth * 0.5, height: dHeight * 0.05)
                    .overlay {
                        HStack {
                            Text(String(modelData.profile.hisE_Waste))
                                .font(.title)
                                .foregroundStyle(colorP.c6)
                                .bold()
                            Spacer()
                            Image(systemName: "macbook.and.iphone")
                                .resizable()
                                .scaledToFit()
                                .frame(width: dWidth * 0.09)
                                .foregroundStyle(colorP.c6)
                                .offset(x: dWidth * 0.03)
                        }
                        .padding(.horizontal, dWidth * 0.12)
                    }
            }
            .offset(y: showFull ? 0 : -dHeight * 0.09)
            .opacity(showFull ? 1 : 0)
        }
        .padding(.all, 15)
    }
    
    func nameAShare() -> some View {
        HStack {
            Text(modelData.profile.username)
                .font(.title)
                .bold()
                .foregroundStyle(Color.black)
                .offset(y: -dWidth * 0.02)
            Button {
                
            } label: {
                Image(systemName: "square.and.arrow.up")
                    .resizable()
                    .scaledToFit()
                    .frame(width: dWidth*0.05)
                    .foregroundStyle(colorP.c6)
                    .offset(y: -dWidth * 0.025)
            }
        }
    }
}
