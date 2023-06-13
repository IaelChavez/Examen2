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
    
    var body: some View {
        ZStack{
            VStack {
                List{
                    Section(header: Text("MENU PRINCIPAL"), footer: Text("").foregroundColor(.white)) {
                        HStack{
                            Image(systemName: "person.fill")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .padding(.trailing, 10)
                            NavigationLink(destination: MenuRegister(), label: {Text("Register")})
                                .foregroundColor(.black)
                        }
                        HStack{
                            Image(systemName: "dollarsign.circle.fill")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .padding(.trailing, 10)
                            NavigationLink(destination: SaleList(), label: {Text("Sales")})
                                .foregroundColor(.black)
                        }
                        HStack{
                            Image(systemName: "cart.fill")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .padding(.trailing, 10)
                            NavigationLink(destination: PurchaseList(), label: {Text("Purchase")})
                                .foregroundColor(.black)
                        }
                    }
                    
                    
                }
                .listStyle(InsetGroupedListStyle())
            }.scrollContentBackground(.hidden)
        }            .background(Color(hex: "#EAEFBD"))
    }
}

struct Menu_Previews: PreviewProvider {
    static var previews: some View {
        Menu()
    }
}
