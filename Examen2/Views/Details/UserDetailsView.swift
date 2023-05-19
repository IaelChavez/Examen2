import SwiftUI
 
struct UserDetailsView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var presentEditUserSheet = false
     
    var user: Users
     
    private func editButton(action: @escaping () -> Void) -> some View {
      Button(action: { action() }) {
        Text("Edit")
      }
    }
     
    var body: some View {
      Form {
          Section(header: Text("Detalle")) {
            Text("Name: \(user.name)")
            Text("Name: \(user.lastName)")
            Text(user.age)
            Text(user.gender)
            Text(user.email)
            Text(user.password)
        }
         
      }
      .navigationBarTitle("Datos de \(user.name)")
      .navigationBarItems(trailing: editButton {
        self.presentEditUserSheet.toggle()
      })
      .onAppear() {
        print("UserDetailsView.onAppear() for \(self.user.name)")
      }
      .onDisappear() {
        print("UserDetailsView.onDisappear()")
      }
      .sheet(isPresented: self.$presentEditUserSheet) {
          UserEditView(viewModel: UserViewModel(user: user), mode: .edit) { result in
          if case .success(let action) = result, action == .delete {
            self.presentationMode.wrappedValue.dismiss()
          }
        }
      }
    }
     
  }
 
