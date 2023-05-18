//
//  MenuRegister.swift
//  Examen2
//
//  Created by ISSC_611_2023 on 24/04/23.
//

import SwiftUI

struct MenuRegister: View {
    var body: some View {
        NavigationView{
            VStack {
                List{
                    Section(header: Text("First header"), footer: Text("")) {
                        HStack{
                            Image(systemName: "person.fill")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .padding(.trailing, 10)
                            NavigationLink(destination: User(), label: {Text("User")})
                                .foregroundColor(.black)
                        }
                        HStack{
                            Image(systemName: "shippingbox.fill")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .padding(.trailing, 10)
                            NavigationLink(destination: Product(), label: {Text("Product")})
                                .foregroundColor(.black)
                        }
                    }
                    
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
                }
                .listStyle(InsetGroupedListStyle())
            }
        }
    }
}

struct MenuRegister_Previews: PreviewProvider {
    static var previews: some View {
        MenuRegister()
    }
}
