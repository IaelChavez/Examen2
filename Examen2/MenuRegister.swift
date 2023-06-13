//
//  MenuRegister.swift
//  Examen2
//
//  Created by ISSC_611_2023 on 24/04/23.
//

import SwiftUI

struct MenuRegister: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var showingNextView = false
    
    var body: some View {
            ZStack{
                LinearGradient(gradient: Gradient(colors: [.blue, .green,
                                                           .yellow]), startPoint: .topLeading, endPoint:
                        .bottomTrailing) .edgesIgnoringSafeArea(.all)
                    .scrollContentBackground(.hidden)
                VStack {
                    List{
                        Section(header: Text("MENU REGISTRO USUARIO"), footer: Text("")) {
                            HStack{
                                Image(systemName: "person.fill")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                    .padding(.trailing, 10)
                                    .foregroundColor(Color.black)
                                NavigationLink(destination: UserList(), label: {Text("User")})
                                    .foregroundColor(.black)
                            }
                            HStack{
                                Image(systemName: "shippingbox.fill")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                    .padding(.trailing, 10)
                                    .foregroundColor(Color.black)
                                NavigationLink(destination: ProductList(), label: {Text("Product")})
                                    .foregroundColor(.black)
                            }
                        }.foregroundColor(Color.white)
                        
                        /*
                         Section(header: Text("First header"), footer: Text("")) {
                         ForEach(menuOptions, id: \.self.0) { option in
                         HStack {
                         Image(systemName: option.1)
                         .resizable()
                         .frame(width: 20, height: 20)
                         .padding(.trailing, 10)
                         
                         }
                         }
                         }*/
                    }.scrollContentBackground(.hidden)
                        .listStyle(InsetGroupedListStyle())
                        .foregroundColor(Color.black)
                }
            }
            

    }
    
    struct MenuRegister_Previews: PreviewProvider {
        static var previews: some View {
            MenuRegister()
        }
    }
}
