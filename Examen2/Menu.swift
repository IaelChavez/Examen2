//
//  Menu.swift
//  Examen2
//
//  Created by ISSC_611_2023 on 24/04/23.
//

import SwiftUI

struct Menu: View {
    let menuOptions = [("Register", "person.fill", MenuRegister()), ("Sales", "dollarsign.circle.fill",MenuRegister()), ("Purchase", "cart.fill",MenuRegister())]
    
    var body: some View {
        NavigationView{
            VStack {
                List{
                    Section(header: Text("First header"), footer: Text("")) {
                        ForEach(menuOptions, id: \.self.0) { option in
                            HStack {
                                Image(systemName: option.1)
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                    .padding(.trailing, 10)
                                NavigationLink(destination: option.2, label: {Text(option.0)})
                                .foregroundColor(.black)
                            }
                            
                        }
                    }
                }
                .listStyle(InsetGroupedListStyle())
            }
        }
    }
}

struct Menu_Previews: PreviewProvider {
    static var previews: some View {
        Menu()
    }
}
