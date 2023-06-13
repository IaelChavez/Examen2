//
//  Sales.swift
//  Examen2
//
//  Created by ISSC_611_2023 on 26/04/23.
//

import SwiftUI

struct Sales: View {
    @State private var id = ""
    @State private var name = ""
    @State private var cant = ""
    @State private var IdV = ""
    @State private var IdC = ""
    @State private var Pieces = ""
    @State private var Subtotal = ""
    @State private var Total = ""
    
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [.blue, .green,
            .yellow]), startPoint: .topLeading, endPoint:
                    .bottomTrailing) .edgesIgnoringSafeArea(.all)
            VStack{
                Text("Venta")
                    .foregroundColor(.white)
                    .font(.title)
                    .fontWeight(.bold)
                    .padding()
                Form{
                    TextField("ID", text: $id)
                    TextField("Nombre", text: $name)
                    TextField("Cantidad", text: $cant)
                    TextField("ID Vendedor", text: $IdV)
                    TextField("ID Compras", text: $IdC)
                    TextField("Piezas", text: $Pieces)
                    SecureField("Subtotal", text: $Subtotal)
                    SecureField("Total", text: $Total)
                }
                Button(action:{
                    
                }){
                    Text("Venta")
                        .foregroundColor(.white)
                        .shadow(color: Color.black.opacity(0.5), radius: 10, x:0, y:10)
                }
            }.scrollContentBackground(.hidden)
        }
    }
}

struct Sales_Previews: PreviewProvider {
    static var previews: some View {
        Sales()
    }
}
