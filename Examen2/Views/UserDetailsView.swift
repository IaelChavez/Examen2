import SwiftUI
 
struct UserDetailsView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var presentEditMovieSheet = false
     
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
        self.presentEditMovieSheet.toggle()
      })
      .onAppear() {
        print("UserDetailsView.onAppear() for \(self.user.name)")
      }
      .onDisappear() {
        print("UserDetailsView.onDisappear()")
      }
      .sheet(isPresented: self.$presentEditMovieSheet) {
        MovieEditView(viewModel: UserViewModel(user: user), mode: .edit) { result in
          if case .success(let action) = result, action == .delete {
            self.presentationMode.wrappedValue.dismiss()
          }
        }
      }
    }
     
  }
 
struct UserDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        let user = Users(id: "Sample title", age: "12", email: "2020", gender: "dfs", lastName: "Juan", name: "Pepe", password: "123")
        return
          NavigationView {
            UserDetailsView(user: user)
          }
    }
}
