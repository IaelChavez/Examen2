import SwiftUI
 
enum ModeUser {
  case new
  case edit
}
 
enum ActionUser {
  case delete
  case done
  case cancel
}
 
struct UserEditView: View {
    @Environment(\.presentationMode) private var presentationMode
    @State var presentActionSheet = false
     
    @ObservedObject var viewModel = UserViewModel()
    var mode: ModeUser = .new
    var completionHandler: ((Result<ActionUser, Error>) -> Void)?
     
     
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
              VStack{
                  Form {
                    Section(header: Text("Nombre")) {
                        TextField("Nombre", text: $viewModel.user.name).foregroundColor(.black)
                    }

                      Section(header: Text("Apellido")) {
                        TextField("Apellido", text: $viewModel.user.lastName).foregroundColor(.black)
                      }
                     
                    Section(header: Text("Edad")) {
                      TextField("Edad", text: $viewModel.user.age).foregroundColor(.black)
                    }
                      Section(header: Text("Genero")) {
                        TextField("Genero", text: $viewModel.user.gender).foregroundColor(.black)
                      }
                      Section(header: Text("Correo")) {
                        TextField("Correo", text: $viewModel.user.email).foregroundColor(.black)
                      }
                      
                      Section(header: Text("Contraseña")) {
                          TextField("Contraseña", text: $viewModel.user.password).foregroundColor(.black)
                      }
                     
                    if mode == .edit {
                      Section {
                        Button("Eliminar Usuario") { self.presentActionSheet.toggle() }
                          .foregroundColor(.red)
                      }
                    }
                  }
                  .navigationTitle(mode == .new ? "Nuevo Usuario" : "Usuario")
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
 
struct UserEditView_Previews: PreviewProvider {
  static var previews: some View {
      let user = Users(id: "", age: "", email: "", gender: "", lastName: "", name: "", password: "")
    let UserViewModel = UserViewModel(user: user)
    return UserEditView(viewModel: UserViewModel, mode: .edit)
  }
}
