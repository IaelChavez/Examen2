//
//  MenuRegister.swift
//  Examen2
//
//  Created by ISSC_611_2023 on 24/04/23.
//

import SwiftUI

struct MenuRegister: View {
    let menuOptions = [("User", "person.fill"), ("Product", "dollarsign.circle.fill")]
    var body: some View {
        VStack {
            List{
                Section(header: Text("First header"), footer: Text("")) {
                    ForEach(menuOptions, id: \.self.0) { option in
                        HStack {
                            Image(systemName: option.1)
                                .resizable()
                                .frame(width: 20, height: 20)
                                .padding(.trailing, 10)
                            Button(option.0) {
                            }
                            .foregroundColor(.black)
                        }
                    }
                }
            }
            .listStyle(InsetGroupedListStyle())
        }
    }
}

struct MenuRegister_Previews: PreviewProvider {
    static var previews: some View {
        MenuRegister()
    }
}
