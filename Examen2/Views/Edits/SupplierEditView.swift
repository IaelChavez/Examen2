import SwiftUI
 
enum ModeSupplier{
  case new
  case edit
}
 
enum ActionSupplier {
  case delete
  case done
  case cancel
}
 
struct SupplierEditView: View {
    @Environment(\.presentationMode) private var presentationMode
    @State var presentActionSheet = false
     
    @ObservedObject var viewModel = SupplierViewModel()
    var mode: ModeSupplier = .new
    var completionHandler: ((Result<ActionSupplier, Error>) -> Void)?
     
     
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
              Color(hex: "#ccd85e")
 .edgesIgnoringSafeArea(.all)
              VStack{
                  Form {
                    Section(header: Text("Company").foregroundColor(.black)) {
                        TextField("Company", text: $viewModel.supplier.company).foregroundColor(.black)
                    }

                      Section(header: Text("Email").foregroundColor(.black)) {
                          TextField("Email", text: $viewModel.supplier.email).foregroundColor(.black)
                      }
                     
                    Section(header: Text("Image").foregroundColor(.black)) {
                        TextField("Image", text: $viewModel.supplier.image).foregroundColor(.black)
                    }
                      Section(header: Text("lastName").foregroundColor(.black)) {
                          TextField("lastName", text: $viewModel.supplier.lastName).foregroundColor(.black)
                      }
                      Section(header: Text("Name").foregroundColor(.black)) {
                          TextField("Name", text: $viewModel.supplier.name).foregroundColor(.black)
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
 
struct SupplierEditView_Previews: PreviewProvider {
  static var previews: some View {
      let supplier = Suppliers(company: "", email: "", image: "", lastName: "", name: "")
      let SupplierViewModel = SupplierViewModel(supplier: supplier)
    return SupplierEditView(viewModel: SupplierViewModel, mode: .edit)
  }
}
