import Foundation
import Combine
import FirebaseFirestore
 
class SuppliersViewModel: ObservableObject {
  @Published var suppliers = [Suppliers]()
   
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
      listenerRegistration = db.collection("suppliers").addSnapshotListener { (querySnapshot, error) in
        guard let documents = querySnapshot?.documents else {
          print("No documents")
          return
        }
         
        self.suppliers = documents.compactMap { queryDocumentSnapshot in
          try? queryDocumentSnapshot.data(as: Suppliers.self)
        }
      }
    }
  }
   
  func removeSuppliers(atOffsets indexSet: IndexSet) {
    let suppliers = indexSet.lazy.map { self.suppliers[$0] }
      suppliers.forEach { supplier in
      if let documentId = supplier.id {
        db.collection("suppliers").document(documentId).delete { error in
          if let error = error {
            print("Unable to remove document: \(error.localizedDescription)")
          }
        }
      }
    }
  }
}

