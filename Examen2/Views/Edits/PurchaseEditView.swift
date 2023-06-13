import SwiftUI
 
enum ModePurchase {
  case new
  case edit
}
 
enum ActionPurchase {
  case delete
  case done
  case cancel
}
 
struct PurchaseEditView: View {
    @Environment(\.presentationMode) private var presentationMode
    @State var presentActionSheet = false
     
    @ObservedObject var viewModel = PurchaseViewModel()
    var mode: ModePurchase = .new
    var completionHandler: ((Result<ActionPurchase, Error>) -> Void)?
     
     
    var cancelButton: some View {
      Button(action: { self.handleCancelTapped() }) {
        Text("Cancel")
      }
    }
     
    var saveButton: some View {
      Button(action: { self.handleDoneTapped() }) {
        Text(mode == .new ? "Done" : "Save")
      }
      .disabled(!viewModel.modified)
    }
     
    var body: some View {
      NavigationView {
          ZStack{
              LinearGradient(gradient: Gradient(colors: [.blue, .green,
                      .yellow]), startPoint: .topLeading, endPoint:
                      .bottomTrailing) .edgesIgnoringSafeArea(.all)
                  .scrollContentBackground(.hidden)
              VStack{
                  Form {
                    Section(header: Text("Nombre")) {
                        TextField("Nombre", text: $viewModel.purchase.name).foregroundColor(.black)
                    }

                      Section(header: Text("Cant")) {
                          TextField("Cant", text: $viewModel.purchase.cant).foregroundColor(.black)
                      }
                     
                    Section(header: Text("idC")) {
                        TextField("idC", text: $viewModel.purchase.idC).foregroundColor(.black)
                    }
                      Section(header: Text("idV")) {
                          TextField("idV", text: $viewModel.purchase.idV).foregroundColor(.black)
                      }
                      Section(header: Text("idProduct")) {
                          TextField("idProduct", text: $viewModel.purchase.idProduct).foregroundColor(.black)
                      }
                      Section(header: Text("Piezas")) {
                          TextField("Piezas", text: $viewModel.purchase.pieces).foregroundColor(.black)
                      }
                      Section(header: Text("Total")) {
                          TextField("Total", text: $viewModel.purchase.total).foregroundColor(.black)
                      }
                      Section(header: Text("Subtotal")) {
                          TextField("Subtotal", text: $viewModel.purchase.subtotal).foregroundColor(.black)
                      }
                    if mode == .edit {
                      Section {
                        Button("Eliminar Compra") { self.presentActionSheet.toggle() }
                          .foregroundColor(.red)
                      }
                    }
                  }
                  .navigationTitle(mode == .new ? "Nueva Compra" : "Compra")
                  .foregroundColor(mode == .new ? Color.white : Color.white)
                  .navigationBarTitleDisplayMode(mode == .new ? .inline : .large)
                  .navigationBarItems(
                    leading: cancelButton,
                    trailing: saveButton
                  )
                  .actionSheet(isPresented: $presentActionSheet) {
                    ActionSheet(title: Text("Estas Seguro?"),
                                buttons: [
                                  .destructive(Text("Eliminar Compra"),
                                               action: { self.handleDeleteTapped() }),
                                  .cancel()
                                ])
                  }
              }.scrollContentBackground(.hidden)
          }
      }
    }
     
    // Action Handlers
     
    func handleCancelTapped() {
      self.dismiss()
    }
     
    func handleDoneTapped() {
      self.viewModel.handleDoneTapped()
      self.dismiss()
    }
     
    func handleDeleteTapped() {
      viewModel.handleDeleteTapped()
      self.dismiss()
      self.completionHandler?(.success(.delete))
    }
     
    func dismiss() {
      self.presentationMode.wrappedValue.dismiss()
    }
  }
 
//struct MovieEditView_Previews: PreviewProvider {
//    static var previews: some View {
//        MovieEditView()
//    }
//}
 
struct PurchaseEditView_Previews: PreviewProvider {
  static var previews: some View {
      let purchase = Purchases(cant: "", idC: "", idProduct: "", idV: "", name: "", pieces: "", subtotal: "", total: "")
      let PurchaseViewModel = PurchaseViewModel(purchase: purchase)
    return PurchaseEditView(viewModel: PurchaseViewModel, mode: .edit)
  }
}
