import Foundation
import Combine
import FirebaseFirestore
 
class SalesViewModel: ObservableObject {
   
  @Published var sale: Sales
  @Published var modified = false
   
  private var cancellables = Set<AnyCancellable>()
   
  init(sale: Sales = Sales(idClient: "", idFerret: "")) {
    self.sale = sale
     
    self.$sale
      .dropFirst()
      .sink { [weak self] sale in
        self?.modified = true
      }
      .store(in: &self.cancellables)
  }
   
  // Firestore
   
  private var db = Firestore.firestore()
   
  private func addSale(_ sale: Sales) {
    do {
      let _ = try db.collection("sales").addDocument(from: sale)
    }
    catch {
      print(error)
    }
  }
   
  private func updateSale(_ sale: Sales) {
    if let documentId = sale.id {
      do {
        try db.collection("sales").document(documentId).setData(from: sale)
      }
      catch {
        print(error)
      }
    }
  }
   
  private func updateOrAddSale() {
    if let _ = sale.id {
      self.updateSale(self.sale)
    }
    else {
      addSale(sale)
    }
  }
   
  private func removeSale() {
    if let documentId = sale.id {
      db.collection("sales").document(documentId).delete { error in
        if let error = error {
          print(error.localizedDescription)
        }
      }
    }
  }
   
  // UI handlers
   
  func handleDoneTapped() {
    self.updateOrAddSale()
  }
   
  func handleDeleteTapped() {
    self.removeSale()
  }
   
}
