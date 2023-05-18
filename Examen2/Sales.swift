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
        VStack{
            Text("Sales")
                .font(.title)
                .fontWeight(.bold)
                .padding()
            Form{
                TextField("ID", text: $id)
                TextField("Nombre", text: $name)
                TextField("Cantidad", text: $cant)
                TextField("IDVendedor", text: $IdV)
                TextField("IDCompras", text: $IdC)
                TextField("Piezas", text: $Pieces)
                SecureField("Subtotal", text: $Subtotal)
                SecureField("Total", text: $Total)
            }
            Button(action:{
                
            }){
                Text("Venta")
            }
        }
    }
}

struct Sales_Previews: PreviewProvider {
    static var previews: some View {
        Sales()
    }
}
