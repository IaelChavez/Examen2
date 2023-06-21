import Foundation
import Combine
import FirebaseFirestore
 
class ClienteViewModel: ObservableObject {
   
  @Published var cliente: Clientes
  @Published var modified = false
   
  private var cancellables = Set<AnyCancellable>()
   
    init(cliente: Clientes = Clientes(age: "", email: "", gender: "",image: "", lastName: "", name: "", password: "")) {
    self.cliente = cliente
     
    self.$cliente
      .dropFirst()
      .sink { [weak self] cliente in
        self?.modified = true
      }
      .store(in: &self.cancellables)
  }
   
  // Firestore
   
  private var db = Firestore.firestore()
   
  private func addCliente(_ cliente: Clientes) {
    do {
      let _ = try db.collection("clientes").addDocument(from: cliente)
    }
    catch {
      print(error)
    }
  }
   
  private func updateCliente(_ cliente: Clientes) {
    if let documentId = cliente.id {
      do {
        try db.collection("clientes").document(documentId).setData(from:  cliente)
      }
      catch {
        print(error)
      }
    }
  }
   
  private func updateOrAddCliente() {
    if let _ = cliente.id {
      self.updateCliente(self.cliente)
    }
    else {
      addCliente(cliente)
    }
  }
   
  private func removeCliente() {
    if let documentId = cliente.id {
      db.collection("clientes").document(documentId).delete { error in
        if let error = error {
          print(error.localizedDescription)
        }
      }
    }
  }
   
  // UI handlers
   
  func handleDoneTapped() {
    self.updateOrAddCliente()
  }
   
  func handleDeleteTapped() {
    self.removeCliente()
  }
   
}
