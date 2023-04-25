//
//  User.swift
//  Examen2
//
//  Created by ISSC_611_2023 on 24/04/23.
//

import SwiftUI

struct User: View {
    @State private var id = ""
    @State private var name = ""
    @State private var lastname = ""
    @State private var age = ""
    @State private var gender = ""
    @State private var user = ""
    @State private var pass = ""
    @State private var pass2 = ""
    
    var body: some View {
        VStack{
            Text("Usuario")
                .font(.title)
                .fontWeight(.bold)
                .padding()
            Form{
                TextField("ID", text: $id)
                TextField("Nombre", text: $name)
                TextField("Apellido", text: $lastname)
                TextField("Edad", text: $age)
                TextField("Genero", text: $gender)
                TextField("Usuario", text: $user)
                SecureField("Contraseña", text: $pass)
                SecureField("Repetir ontraseña", text: $pass2)
            }
            Button(action:{
                
            }){
                Text("Registrar")
            }
        }
    }
}

struct User_Previews: PreviewProvider {
    static var previews: some View {
        User()
    }
}
