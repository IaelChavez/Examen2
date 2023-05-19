import SwiftUI
 
enum Mode {
  case new
  case edit
}
 
enum Action {
  case delete
  case done
  case cancel
}
 
struct UserEditView: View {
    @Environment(\.presentationMode) private var presentationMode
    @State var presentActionSheet = false
     
    @ObservedObject var viewModel = UserViewModel()
    var mode: Mode = .new
    var completionHandler: ((Result<Action, Error>) -> Void)?
     
     
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
        Form {
          Section(header: Text("User")) {
            TextField("name", text: $viewModel.user.name)
            TextField("lastName", text: $viewModel.user.lastName)
          }
           
          Section(header: Text("Description")) {
            TextField("Description", text: $viewModel.user.name)
          }
           
          if mode == .edit {
            Section {
              Button("Delete User") { self.presentActionSheet.toggle() }
                .foregroundColor(.red)
            }
          }
        }
        .navigationTitle(mode == .new ? "New User" : viewModel.user.name)
        .navigationBarTitleDisplayMode(mode == .new ? .inline : .large)
        .navigationBarItems(
          leading: cancelButton,
          trailing: saveButton
        )
        .actionSheet(isPresented: $presentActionSheet) {
          ActionSheet(title: Text("Are you sure?"),
                      buttons: [
                        .destructive(Text("Delete User"),
                                     action: { self.handleDeleteTapped() }),
                        .cancel()
                      ])
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
      let user = Users(id: "Sample title", age: "Sample Description", email: "2020", gender: "dfs", lastName: "sdf", name: "fsd", password: "fsd")
    let UserViewModel = UserViewModel(user: user)
    return UserEditView(viewModel: UserViewModel, mode: .edit)
  }
}
