//
//  Product.swift
//  Examen2
//
//  Created by ISSC_612_2023 on 24/04/23.
//

import SwiftUI

struct Product: View {
    @State private var id = ""
    @State private var name = ""
    @State private var description = ""
    @State private var unit = ""
    @State private var cost = ""
    @State private var price = ""
    @State private var utility = ""
    
    var body: some View {
        VStack{
            Text("Producto")
                .font(.title)
                .fontWeight(.bold)
                .padding()
            Form{
                TextField("ID", text: $id)
                TextField("Nombre", text: $name)
                TextField("Descripcion", text: $description)
                TextField("Unidad", text: $unit)
                TextField("Costo", text: $cost)
                TextField("Precio", text: $price)
                TextField("Utilidad", text: $utility)
            }
            Button(action:{
                
            }){
                Text("Registrar")
            }
        }
    }
}

struct Product_Previews: PreviewProvider {
    static var previews: some View {
        Product()
    }
}
