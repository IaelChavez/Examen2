import Foundation
import Combine
import FirebaseFirestore
 
class PurchaseViewModel: ObservableObject {
   
  @Published var purchase: Purchases
  @Published var modified = false
   
  private var cancellables = Set<AnyCancellable>()
   
  init(purchase: Purchases = Purchases(cant: "", idC: "", idProduct: "", idV: "", name: "", pieces: "", subtotal: "", total: "")) {
    self.purchase = purchase
     
    self.$purchase
      .dropFirst()
      .sink { [weak self] purchase in
        self?.modified = true
      }
      .store(in: &self.cancellables)
  }
   
  // Firestore
   
  private var db = Firestore.firestore()
   
  private func addPurchase(_ purchase: Purchases) {
    do {
      let _ = try db.collection("purchases").addDocument(from: purchase)
    }
    catch {
      print(error)
    }
  }
   
  private func updatePurchase(_ purchase: Purchases) {
    if let documentId = purchase.id {
      do {
        try db.collection("purchases").document(documentId).setData(from: purchase)
      }
      catch {
        print(error)
      }
    }
  }
   
  private func updateOrAddPurchase() {
    if let _ = purchase.id {
      self.updatePurchase(self.purchase)
    }
    else {
      addPurchase(purchase)
    }
  }
   
  private func removePurchase() {
    if let documentId = purchase.id {
      db.collection("purchases").document(documentId).delete { error in
        if let error = error {
          print(error.localizedDescription)
        }
      }
    }
  }
   
  // UI handlers
   
  func handleDoneTapped() {
    self.updateOrAddPurchase()
  }
   
  func handleDeleteTapped() {
    self.removePurchase()
  }
   
}
