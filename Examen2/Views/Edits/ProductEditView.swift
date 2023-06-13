import SwiftUI
 
enum ModeProduct {
  case new
  case edit
}
 
enum ActionProduct {
  case delete
  case done
  case cancel
}
 
struct ProductEditView: View {
    @Environment(\.presentationMode) private var presentationMode
    @State var presentActionSheet = false
     
    @ObservedObject var viewModel = ProductViewModel()
    var mode: ModeProduct = .new
    var completionHandler: ((Result<ActionProduct, Error>) -> Void)?
     
     
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
                        TextField("Nombre", text: $viewModel.product.name).foregroundColor(.black)
                    }

                      Section(header: Text("Descripcion")) {
                          TextField("Descripcion", text: $viewModel.product.description).foregroundColor(.black)
                      }
                     
                    Section(header: Text("Costo")) {
                        TextField("Costo", text: $viewModel.product.cost).foregroundColor(.black)
                    }
                      Section(header: Text("Precio")) {
                          TextField("Precio", text: $viewModel.product.price).foregroundColor(.black)
                      }
                      Section(header: Text("Cantidad")) {
                          TextField("Cantidad", text: $viewModel.product.units).foregroundColor(.black)
                      }
                      Section(header: Text("Utilidad")) {
                          TextField("Utilidad", text: $viewModel.product.utility).foregroundColor(.black)
                      }
                    if mode == .edit {
                      Section {
                        Button("Eliminar Producto") { self.presentActionSheet.toggle() }
                          .foregroundColor(.red)
                      }
                    }
                  }
                  .navigationTitle(mode == .new ? "Nuevo Producto" : "Producto")
                  .foregroundColor(mode == .new ? Color.white : Color.white)
                  .navigationBarTitleDisplayMode(mode == .new ? .inline : .large)
                  .navigationBarItems(
                    leading: cancelButton,
                    trailing: saveButton
                  )
                  .actionSheet(isPresented: $presentActionSheet) {
                    ActionSheet(title: Text("Estas Seguro?"),
                                buttons: [
                                  .destructive(Text("Eliminar Producto"),
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
 
struct ProductEditView_Previews: PreviewProvider {
  static var previews: some View {
      let product = Products(cost: "", description: "", name: "", price: "", units: "", utility: "")
      let ProductViewModel = ProductViewModel(product: product)
    return ProductEditView(viewModel: ProductViewModel, mode: .edit)
  }
}
