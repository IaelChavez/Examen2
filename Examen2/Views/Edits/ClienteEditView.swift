import SwiftUI
 
enum ModeCliente {
  case new
  case edit
}
 
enum ActionCliente {
  case delete
  case done
  case cancel
}
 
struct ClienteEditView: View {
    @Environment(\.presentationMode) private var presentationMode
    @State var presentActionSheet = false
     
    @ObservedObject var viewModel = ClienteViewModel()
    var mode: ModeCliente = .new
    var completionHandler: ((Result<ActionCliente, Error>) -> Void)?
     
     
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
                    Section(header: Text("Age").foregroundColor(.black)) {
                        TextField("Age", text: $viewModel.cliente.age).foregroundColor(.black)
                    }

                      Section(header: Text("Email").foregroundColor(.black)) {
                        TextField("Email", text: $viewModel.cliente.email).foregroundColor(.black)
                      }
                     
                    Section(header: Text("Gender").foregroundColor(.black)) {
                      TextField("Gender", text: $viewModel.cliente.gender).foregroundColor(.black)
                    }
                      Section(header: Text("Image").foregroundColor(.black)) {
                        TextField("Image", text: $viewModel.cliente.image).foregroundColor(.black)
                      }
                      Section(header: Text("LastName").foregroundColor(.black)) {
                        TextField("LastName", text: $viewModel.cliente.lastName).foregroundColor(.black)
                      }
                      
                      Section(header: Text("Nombre").foregroundColor(.black)) {
                          TextField("Nombre", text: $viewModel.cliente.name).foregroundColor(.black)
                      }
                      Section(header: Text("Password").foregroundColor(.black)) {
                          TextField("Password", text: $viewModel.cliente.password).foregroundColor(.black)
                      }
                     
                    if mode == .edit {
                      Section {
                        Button("Eliminar Usuario") { self.presentActionSheet.toggle() }
                          .foregroundColor(.red)
                      }
                    }
                  }
                  .navigationTitle(mode == .new ? "Nuevo Cliente" : "Cliente")
                  .foregroundColor(mode == .new ? Color.white : Color.white)
                  .navigationBarTitleDisplayMode(mode == .new ? .inline : .large)
                  .navigationBarItems(
                    leading: cancelButton,
                    trailing: saveButton
                  )
                  .actionSheet(isPresented: $presentActionSheet) {
                    ActionSheet(title: Text("Estas Seguro?"),
                                buttons: [
                                  .destructive(Text("Eliminar Usuario"),
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
 
struct ClienteEditView_Previews: PreviewProvider {
  static var previews: some View {
      let cliente = Clientes(id: "", age: "", email: "", gender: "", image: "", lastName: "", name: "", password: "")
    let ClienteViewModel = ClienteViewModel(cliente: cliente)
    return ClienteEditView(viewModel: ClienteViewModel, mode: .edit)
  }
}
