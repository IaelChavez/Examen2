import Foundation
import Combine
import FirebaseFirestore
 
class ClientesViewModel: ObservableObject {
  @Published var clientes = [Clientes]()
   
  private var db = Firestore.firestore()
  private var listenerRegistration: ListenerRegistration?
   
  deinit {
    unsubscribe()
  }
   
  func unsubscribe() {
    if listenerRegistration != nil {
      listenerRegistration?.remove()
      listenerRegistration = nil
    }
  }
   
  func subscribe() {
    if listenerRegistration == nil {
      listenerRegistration = db.collection("clientes").addSnapshotListener { (querySnapshot, error) in
        guard let documents = querySnapshot?.documents else {
          print("No documents")
          return
        }
         
        self.clientes = documents.compactMap { queryDocumentSnapshot in
          try? queryDocumentSnapshot.data(as: Clientes.self)
        }
      }
    }
  }
   
  func removeClientes(atOffsets indexSet: IndexSet) {
    let clientes = indexSet.lazy.map { self.clientes[$0] }
      clientes.forEach { cliente in
      if let documentId = cliente.id {
        db.collection("clientes").document(documentId).delete { error in
          if let error = error {
            print("Unable to remove document: \(error.localizedDescription)")
          }
        }
      }
    }
  }
}
