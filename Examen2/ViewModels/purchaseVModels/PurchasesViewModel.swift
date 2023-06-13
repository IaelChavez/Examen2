import Foundation
import Combine
import FirebaseFirestore
 
class PurchasesViewModel: ObservableObject {
  @Published var purchases = [Purchases]()
   
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
      listenerRegistration = db.collection("purchases").addSnapshotListener { (querySnapshot, error) in
        guard let documents = querySnapshot?.documents else {
          print("No documents")
          return
        }
         
        self.purchases = documents.compactMap { queryDocumentSnapshot in
          try? queryDocumentSnapshot.data(as: Purchases.self)
        }
      }
    }
  }
   
  func removePurchases(atOffsets indexSet: IndexSet) {
    let purchases = indexSet.lazy.map { self.purchases[$0] }
      purchases.forEach { purchase in
      if let documentId = purchase.id {
        db.collection("purchases").document(documentId).delete { error in
          if let error = error {
            print("Unable to remove document: \(error.localizedDescription)")
          }
        }
      }
    }
  }
}
