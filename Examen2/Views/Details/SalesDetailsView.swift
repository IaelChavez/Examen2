import SwiftUI
 
struct SalesDetailsView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var presentEditClienteSheet = false
     
    var sale: Sales
     
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
                      Text("idClient: \(sale.idClient)")
                      Text("idFerret: \(sale.idFerret)")       }
                   
                }
                .navigationBarTitle("Datos de \(sale.idClient)")
                .navigationBarItems(trailing: editButton {
                  self.presentEditClienteSheet.toggle()
                })
                .onAppear() {
                  print("SaleDetailsView.onAppear() for \(self.sale.idClient)")
                }
                .onDisappear() {
                  print("SaleDetailsView.onDisappear()")
                }
                .sheet(isPresented: self.$presentEditClienteSheet) {
                    SalesEditView(viewModel: SalesViewModel(sale: sale), mode: .edit) { result in
                    if case .success(let action) = result, action == .delete {
                      self.presentationMode.wrappedValue.dismiss()
                    }
                  }
                }
            }.scrollContentBackground(.hidden)
        }
    }
     
  }
 
