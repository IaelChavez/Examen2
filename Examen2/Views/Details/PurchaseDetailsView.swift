import SwiftUI
 
struct PurchaseDetailsView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var presentEditUserSheet = false
     
    var purchase: Purchases
     
    private func editButton(action: @escaping () -> Void) -> some View {
      Button(action: { action() }) {
        Text("Edit")
      }
    }
     
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [.blue, .green,
            .yellow]), startPoint: .topLeading, endPoint:
                    .bottomTrailing) .edgesIgnoringSafeArea(.all)
            VStack{
                Form {
                    Section(header: Text("Detalle")) {
                      Text("Name: \(purchase.name)")
                      Text("IdC: \(purchase.idC)")
                      Text("IdProduct: \(purchase.idProduct)")
                      Text("IdV: \(purchase.idV)")
                      Text("Cant: \(purchase.cant)")
                      Text("Pieces: \(purchase.pieces)")
                      Text("Subtotal: \(purchase.subtotal)")
                      Text("Toatal: \(purchase.total)")
                  }
                   
                }
                .navigationBarTitle("Datos de \(purchase.name)")
                .navigationBarItems(trailing: editButton {
                  self.presentEditUserSheet.toggle()
                })
                .onAppear() {
                  print("PurchaseDetailsView.onAppear() for \(self.purchase.name)")
                }
                .onDisappear() {
                  print("PurchaseDetailsView.onDisappear()")
                }
                .sheet(isPresented: self.$presentEditUserSheet) {
                    PurchaseEditView(viewModel: PurchaseViewModel(purchase: purchase), mode: .edit) { result in
                    if case .success(let action) = result, action == .delete {
                      self.presentationMode.wrappedValue.dismiss()
                    }
                  }
                }
            }.scrollContentBackground(.hidden)
        }
      
    }
     
  }
 
