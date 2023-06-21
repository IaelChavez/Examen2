//
//  Menu.swift
//  Examen2
//
//  Created by ISSC_611_2023 on 24/04/23.
//

import SwiftUI

struct Menu: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var showingNextView = false
    @State private var searchText = ""
    let imageSize: CGFloat = 100
    
    var body: some View {
        ZStack{
            VStack {
                HStack {
                    Image(systemName: "arrow.left")
                        .foregroundColor(.black)
                        .font(.system(size: 20))
                    
                    Spacer()
                    
                    TextField("Buscar", text: $searchText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.trailing, 10)
                    
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.black)
                        .font(.system(size: 20))
                    
                }
                VStack {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(Color.gray.opacity(0.2))
                        .frame(width: 350, height: 150)
                        .overlay(
                            Image("banner")
                                .resizable()
                                .foregroundColor(.black)
                                .padding(20)
                        )
                }
                .padding()
                
                List{
                    Section(header: Text("MENU PRINCIPAL"), footer: Text("").foregroundColor(.white)) {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 20) {
                                Button(action: {}) {
                                    Text("Users")
                                        .foregroundColor(.white)
                                }
                                .buttonStyle(CustomButtonStyle())
                                
                                Button(action: {}) {
                                    Text("Products")
                                        .foregroundColor(.white)
                                }
                                .buttonStyle(CustomButtonStyle())
                                
                                Button(action: {}) {
                                    Text("Home")
                                        .foregroundColor(.white)
                                }
                                .buttonStyle(CustomButtonStyle())
                                
                                Button(action: {}) {
                                    Text("Sales")
                                        .foregroundColor(.white)
                                }
                                .buttonStyle(CustomButtonStyle())
                            }
                        }
                    }
                    VStack {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(Color.gray.opacity(0.2))
                            .frame(width: 300, height: 250)
                            .overlay(
                                Image("huronprincipal")

                                    .foregroundColor(.black)
                                    .padding(20)
                            )
                    }
                }.listRowBackground(Color(hex: "#EAEFBD"))
                .listStyle(InsetGroupedListStyle())
                
                
            }.scrollContentBackground(.hidden)
        }            .background(Color(hex: "#ccd85e"))
    }
}

struct Menu_Previews: PreviewProvider {
    static var previews: some View {
        Menu()
    }
}
