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
        ZStack{
            LinearGradient(gradient: Gradient(colors: [.blue, .green,
            .yellow]), startPoint: .topLeading, endPoint:
                    .bottomTrailing) .edgesIgnoringSafeArea(.all)
            VStack{
                Text("Compra")
                    .foregroundColor(.white)
                    .font(.title)
                    .fontWeight(.bold)
                    .padding()
                Form{
                    TextField("ID Producto", text: $id)
                    TextField("Nombre", text: $name)
                    TextField("Piezas", text: $cant)
                    TextField("ID Administrador", text: $IdA)
                }
                Button(action:{
                    
                }){
                    Text("Alta")
                        .foregroundColor(.white)
                        .shadow(color: Color.black.opacity(0.5), radius: 10, x:0, y:10)
                }
            }.scrollContentBackground(.hidden)
        }
    }
}

struct Purchase_Previews: PreviewProvider {
    static var previews: some View {
        Purchase()
    }
}
