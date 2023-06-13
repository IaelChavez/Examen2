import SwiftUI
 
struct SaleDetailsView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var presentEditUserSheet = false
     
    var sale: Sale
     
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
                      Text("IdA: \(sale.IdA)")
                      Text("IdProduct: \(sale.idProduct)")
                      Text("name: \(sale.name)")
                      Text("Pieces: \(sale.pieces)")        }
                   
                }
                .navigationBarTitle("Datos de \(sale.name)")
                .navigationBarItems(trailing: editButton {
                  self.presentEditUserSheet.toggle()
                })
                .onAppear() {
                  print("SaleDetailsView.onAppear() for \(self.sale.name)")
                }
                .onDisappear() {
                  print("SaleDetailsView.onDisappear()")
                }
                .sheet(isPresented: self.$presentEditUserSheet) {
                    SaleEditView(viewModel: SaleViewModel(sale: sale), mode: .edit) { result in
                    if case .success(let action) = result, action == .delete {
                      self.presentationMode.wrappedValue.dismiss()
                    }
                  }
                }
            }.scrollContentBackground(.hidden)
        }
    }
     
  }
 
