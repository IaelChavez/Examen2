import SwiftUI
 
struct SupplierDetailsView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var presentEditClienteSheet = false
     
    var supplier: Suppliers
     
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
                      Text("Company: \(supplier.company)")
                      Text("Email: \(supplier.email)")
                      Text("Image: \(supplier.image)")
                      Text("LastName: \(supplier.lastName)")
                      Text("Name: \(supplier.name)")
                  }
                   
                }
                .navigationBarTitle("Datos de \(supplier.name)")
                .navigationBarItems(trailing: editButton {
                  self.presentEditClienteSheet.toggle()
                })
                .onAppear() {
                  print("SupplierDetailsView.onAppear() for \(self.supplier.name)")
                }
                .onDisappear() {
                  print("SupplierDetailsView.onDisappear()")
                }
                .sheet(isPresented: self.$presentEditClienteSheet) {
                    SupplierEditView(viewModel: SupplierViewModel(supplier: supplier), mode: .edit) { result in
                    if case .success(let action) = result, action == .delete {
                      self.presentationMode.wrappedValue.dismiss()
                    }
                  }
                }
            }.scrollContentBackground(.hidden)
        }
      
    }
     
  }
 
