import SwiftUI
import Firebase

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var isLoggedIn = false
    @State private var loginError: LoginError? = nil
    
    var body: some View{
        if isLoggedIn {
            Home()
        }
        else{
            content
        }
    }
    
    
    var content: some View {
        NavigationView{
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.blue, .green,
                                                           .yellow]), startPoint: .topLeading, endPoint:
                        .bottomTrailing) .edgesIgnoringSafeArea(.all)
                Image("fondologin")
                    .resizable()
                    .ignoresSafeArea()
                
                VStack {
                    
                    Text("Inicio de sesión")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.bottom, 50)
                        .foregroundColor(.white)
                    TextField("Correo", text: $email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                        .shadow(color: Color.black.opacity(0.3), radius: 10, x:0, y:10)
                        .autocapitalization(.none)
                    SecureField("Contraseña", text: $password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                        .shadow(color: Color.black.opacity(0.3), radius: 10, x:0, y:10)
                    Button(action: {
                        signIn()
                    }) {
                        Text("Iniciar Sesion")
                            .cornerRadius(10)
                            .foregroundColor(.white)
                            .padding(.horizontal, 18)
                            .padding(.vertical, 1)
                        
                        
                        
                    }.buttonStyle(CustomButtonStyle())
                    
                    Button(action: {
                        register()
                    }) {
                        Text("Registrar Usuario")
                            .cornerRadius(10)
                            .foregroundColor(.white)
                            .padding(.horizontal, 1)
                            .padding(.vertical, 1)
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
                loginError = LoginError(message: error?.localizedDescription ?? "")
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

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

struct LoginError: Identifiable {
    let id = UUID()
    let message: String
}
