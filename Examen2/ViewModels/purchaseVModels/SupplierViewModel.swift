import Foundation
import Combine
import FirebaseFirestore
 
class SupplierViewModel: ObservableObject {
   
  @Published var supplier: Suppliers
  @Published var modified = false
   
  private var cancellables = Set<AnyCancellable>()
   
  init(supplier: Suppliers = Suppliers(company: "", email: "", image: "", lastName: "", name: "")) {
    self.supplier = supplier
     
      
    self.$supplier
      .dropFirst()
      .sink { [weak self] supplier in
        self?.modified = true
      }
      .store(in: &self.cancellables)
  }
   
  // Firestore
   
  private var db = Firestore.firestore()
   
  private func addSupplier(_ supplier: Suppliers) {
    do {
      let _ = try db.collection("suppliers").addDocument(from: supplier)
    }
    catch {
      print(error)
    }
  }
   
  private func updateSupplier(_ supplier: Suppliers) {
    if let documentId = supplier.id {
      do {
        try db.collection("suppliers").document(documentId).setData(from: supplier)
      }
      catch {
        print(error)
      }
    }
  }
   
  private func updateOrAddSuppliers() {
    if let _ = supplier.id {
      self.updateSupplier(self.supplier)
    }
    else {
      addSupplier(supplier)
    }
  }
   
  private func removeSuppliers() {
    if let documentId = supplier.id {
      db.collection("suppliers").document(documentId).delete { error in
        if let error = error {
          print(error.localizedDescription)
        }
      }
    }
  }
   
  // UI handlers
   
  func handleDoneTapped() {
    self.updateOrAddSuppliers()
  }
   
  func handleDeleteTapped() {
    self.removeSuppliers()
  }
   
}
