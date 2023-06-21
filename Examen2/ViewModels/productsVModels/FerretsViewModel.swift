import Foundation
import Combine
import FirebaseFirestore
 
class FerretsViewModel: ObservableObject {
  @Published var ferrets = [Ferrets]()
   
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
      listenerRegistration = db.collection("ferrets").addSnapshotListener { (querySnapshot, error) in
        guard let documents = querySnapshot?.documents else {
          print("No documents")
          return
        }
         
        self.ferrets = documents.compactMap { queryDocumentSnapshot in
          try? queryDocumentSnapshot.data(as: Ferrets.self)
        }
      }
    }
  }
   
  func removeFerrets(atOffsets indexSet: IndexSet) {
    let ferrets = indexSet.lazy.map { self.ferrets[$0] }
      ferrets.forEach { ferret in
      if let documentId = ferret.id {
        db.collection("ferrets").document(documentId).delete { error in
          if let error = error {
            print("Unable to remove document: \(error.localizedDescription)")
          }
        }
      }
    }
  }
}
