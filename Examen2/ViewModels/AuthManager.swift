import FirebaseAuth
import Foundation

class AuthManager: ObservableObject {
    @Published var isLoggedIn = false
    
    func login(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            guard error == nil else {
                print("Error al iniciar sesión: \(error!.localizedDescription)")
                return
            }
            
            self?.isLoggedIn = true
            print("Inicio de sesión exitoso")
        }
    }
    
    func logout() {
        do {
            try Auth.auth().signOut()
            isLoggedIn = false
            print("Cierre de sesión exitoso")
        } catch let error {
            print("Error al cerrar sesión: \(error.localizedDescription)")
        }
    }
}
