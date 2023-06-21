import SwiftUI
 
struct FerretDetailsView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var presentEditClienteSheet = false
     
    var ferret: Ferrets
     
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
                      Text("Age: \(ferret.age)")
                        Text("Color: \(ferret.color)")
                      Text("idSupplier: \(ferret.idSupplier)")
                      Text("Image: \(ferret.image)")
                      Text("Nationality: \(ferret.nationality)")
                      Text("Price: \(ferret.price)")
                        Text("Species: \(ferret.species)")
                  }
                   
                }
                .navigationBarTitle("Datos de \(ferret.age)")
                .navigationBarItems(trailing: editButton {
                  self.presentEditClienteSheet.toggle()
                })
                .onAppear() {
                  print("FerretDetailsView.onAppear() for \(self.ferret.age)")
                }
                .onDisappear() {
                  print("FerretDetailsView.onDisappear()")
                }
                .sheet(isPresented: self.$presentEditClienteSheet) {
                    FerretEditView(viewModel: FerretViewModel(ferret: ferret), mode: .edit) { result in
                    if case .success(let action) = result, action == .delete {
                      self.presentationMode.wrappedValue.dismiss()
                    }
                  }
                }
            }.scrollContentBackground(.hidden)
        }
      
    }
     
  }
