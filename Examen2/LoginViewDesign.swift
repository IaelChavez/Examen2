//
//  LoginViewDesign.swift
//  Examen2
//
//  Created by ISSC_611_2023 on 07/06/23.
//

import SwiftUI
import Firebase

struct LoginViewDesign: View {
    @State private var email = ""
    @State private var password = ""
    @State private var isLoggedIn = false
    @State private var loginErrors: LoginErrors? = nil
    
    
    var body: some View {
        NavigationView{
            ZStack {
                Image("fondologin")
                    .resizable()
                    .ignoresSafeArea()
                
                VStack {
                    Text("Inicio de sesión")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.bottom, 50)
                        .foregroundColor(.white)
                    TextField("Nombre de usuario", text: $email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                        .shadow(color: Color.black.opacity(0.3), radius: 10, x:0, y:10)
                    SecureField("Contraseña", text: $password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                        .shadow(color: Color.black.opacity(0.3), radius: 10, x:0, y:10)
                    NavigationLink(destination: Menu(), label: {Text("Iniciar Sesion")
                            .padding(.horizontal, 20)
                            .padding(.vertical, 1)
                    })
                        .buttonStyle(CustomButtonStyle())

                        .onTapGesture {
                            signIn()
                        }
                        .alert(item: $loginErrors) { error in
                            Alert(title: Text("Error"), message: Text(error.message), dismissButton: .default(Text("OK")))
                        }
                    
                    Button(action: {
                        register()
                    }) {
                        Text("Registrar Usuario")
                            .cornerRadius(10)
                            .foregroundColor(.white)
                            .padding(.horizontal, 1) // Ajustar el relleno horizontal según el tamaño deseado
                            .padding(.vertical, 1)
                            .cornerRadius(10)
                    }
                    .buttonStyle(CustomButtonStyle())
                }
            }
        }
    }
    
    func signIn() {
        Auth.auth().signIn(withEmail: email, password: password){ result, error in
            if error == nil {
                // Inicio de sesión exitoso
                isLoggedIn = true
                print("Hola")
                // Aquí puedes realizar acciones adicionales después del inicio de sesión
            } else {
                // Ocurrió un error durante el inicio de sesión
                loginErrors = LoginErrors(message: error?.localizedDescription ?? "")
            }
            
        }
    }
    
    func register() {
        Auth.auth().createUser(withEmail: email, password: password){ result, error in
            if error != nil {
                print(error!.localizedDescription)
            }
        }
    }
}


struct LoginViewDesign_Previews: PreviewProvider {
    static var previews: some View {
        LoginViewDesign()

    }
}

struct LoginErrors: Identifiable {
    let id = UUID()
    let message: String
}
