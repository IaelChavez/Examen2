//
//  Purchase.swift
//  Examen2
//
//  Created by ISSC_611_2023 on 26/04/23.
//

import SwiftUI

struct Purchase: View {
    @State private var id = ""
    @State private var name = ""
    @State private var cant = ""
    @State private var IdA = ""

    
    var body: some View {
        VStack{
            Text("Purchase")
                .font(.title)
                .fontWeight(.bold)
                .padding()
            Form{
                TextField("IDProducto", text: $id)
                TextField("Nombre", text: $name)
                TextField("Piezas", text: $cant)
                TextField("IDAdministrador", text: $IdA)
            }
            Button(action:{
                
            }){
                Text("Alta")
            }
        }
    }
}

struct Purchase_Previews: PreviewProvider {
    static var previews: some View {
        Purchase()
    }
}
