import Foundation
import Combine
import FirebaseFirestore
 
class ProductViewModel: ObservableObject {
   
  @Published var product: Products
  @Published var modified = false
   
  private var cancellables = Set<AnyCancellable>()
   
  init(product: Products = Products(cost: "", description: "", name: "", price: "", units: "", utility: "")) {
    self.product = product
     
    self.$product
      .dropFirst()
      .sink { [weak self] product in
        self?.modified = true
      }
      .store(in: &self.cancellables)
  }
   
  // Firestore
   
  private var db = Firestore.firestore()
   
  private func addProduct(_ product: Products) {
    do {
      let _ = try db.collection("products").addDocument(from: product)
    }
    catch {
      print(error)
    }
  }
   
  private func updateProduct(_ product: Products) {
    if let documentId = product.id {
      do {
        try db.collection("products").document(documentId).setData(from: product)
      }
      catch {
        print(error)
      }
    }
  }
   
  private func updateOrAddProduct() {
    if let _ = product.id {
      self.updateProduct(self.product)
    }
    else {
      addProduct(product)
    }
  }
   
  private func removeProduct() {
    if let documentId = product.id {
      db.collection("products").document(documentId).delete { error in
        if let error = error {
          print(error.localizedDescription)
        }
      }
    }
  }
   
  // UI handlers
   
  func handleDoneTapped() {
    self.updateOrAddProduct()
  }
   
  func handleDeleteTapped() {
    self.removeProduct()
  }
   
}


