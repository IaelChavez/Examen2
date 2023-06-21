import Foundation
import Combine
import FirebaseFirestore
 
class FerretViewModel: ObservableObject {
   
  @Published var ferret: Ferrets
  @Published var modified = false
   
  private var cancellables = Set<AnyCancellable>()
   
    init(ferret: Ferrets = Ferrets(age: "", color: "", idSupplier: "", image: "", nationality: "", price: "", species: "" )) {
    self.ferret = ferret
        
     
    self.$ferret
      .dropFirst()
      .sink { [weak self] ferret in
        self?.modified = true
      }
      .store(in: &self.cancellables)
  }
   
  // Firestore
   
  private var db = Firestore.firestore()
   
  private func addFerret(_ ferret: Ferrets) {
    do {
      let _ = try db.collection("ferrets").addDocument(from: ferret)
    }
    catch {
      print(error)
    }
  }
   
  private func updateFerrets(_ ferret: Ferrets) {
    if let documentId = ferret.id {
      do {
        try db.collection("ferrets").document(documentId).setData(from: ferret)
      }
      catch {
        print(error)
      }
    }
  }
   
  private func updateOrAddFerret() {
    if let _ = ferret.id {
      self.updateFerrets(self.ferret)
    }
    else {
      addFerret(ferret)
    }
  }
   
  private func removeFerret() {
    if let documentId = ferret.id {
      db.collection("ferrets").document(documentId).delete { error in
        if let error = error {
          print(error.localizedDescription)
        }
      }
    }
  }
   
  // UI handlers
   
  func handleDoneTapped() {
    self.updateOrAddFerret()
  }
   
  func handleDeleteTapped() {
    self.removeFerret()
  }
   
}


