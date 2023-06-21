import SwiftUI
 
struct ClienteDetailsView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var presentEditClienteSheet = false
     
    var cliente: Clientes
     
    private func editButton(action: @escaping () -> Void) -> some View {
      Button(action: { action() }) {
        Text("Edit")
      }
    }
     
    var body: some View {
        ZStack{

            VStack{
                Form {
                    Section(header: Text("Detalle")) {
                      Text("Age: \(cliente.age)")
                      Text("Email: \(cliente.email)")
                      Text("Gender: \(cliente.gender)")
                      Text("Image: \(cliente.image)")
                        Text("Last Name: \(cliente.lastName)")
                      Text("Name: \(cliente.name)")
                        Text("Password: \(cliente.password)")
                  }
                   
                }
                .navigationBarTitle("Datos de \(cliente.name)")
                .navigationBarItems(trailing: editButton {
                  self.presentEditClienteSheet.toggle()
                })
                .onAppear() {
                  print("ClienteDetailsView.onAppear() for \(self.cliente.name)")
                }
                .onDisappear() {
                  print("ClienteDetailsView.onDisappear()")
                }
                .sheet(isPresented: self.$presentEditClienteSheet) {
                    ClienteEditView(viewModel: ClienteViewModel(cliente: cliente), mode: .edit) { result in
                    if case .success(let action) = result, action == .delete {
                      self.presentationMode.wrappedValue.dismiss()
                    }
                  }
                }
            }.scrollContentBackground(.hidden)
        }
    }
     
  }
 
