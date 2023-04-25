//
//  LoginView.swift
//  Examen2
//
//  Created by ISSC_611_2023 on 24/04/23.
//

import SwiftUI

struct LoginView: View {
    @State private var username = ""
    @State private var password = ""
    @State private var isLoggedIn = false
    
    var body: some View {
        VStack {
            Text("Inicio de sesión")
                .font(.title)
                .fontWeight(.bold)
                .padding(.bottom, 50)
            
            if isLoggedIn {
                Text("¡Bienvenido!")
            } else {
                VStack {
                    TextField("Nombre de usuario", text: $username)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    
                    SecureField("Contraseña", text: $password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    
                    Button("Iniciar sesión") {
                        // Aquí puedes agregar la lógica para validar el inicio de sesión
                        isLoggedIn = true
                    }
                }
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
