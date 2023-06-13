import SwiftUI
 
enum ModeSale {
  case new
  case edit
}
 
enum ActionSale {
  case delete
  case done
  case cancel
}
 
struct SaleEditView: View {
    @Environment(\.presentationMode) private var presentationMode
    @State var presentActionSheet = false
     
    @ObservedObject var viewModel = SaleViewModel()
    var mode: ModeSale = .new
    var completionHandler: ((Result<ActionSale, Error>) -> Void)?
     
     
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
                  .scrollContentBackground(.hidden)
              VStack{
                  Form {
                  Section(header: Text("IdA")) {
                      TextField("IdA", text: $viewModel.sale.IdA).foregroundColor(.black)
                  }

                    Section(header: Text("Id del producto")) {
                        TextField("idProducto", text: $viewModel.sale.idProduct).foregroundColor(.black)
                    }
                   
                  Section(header: Text("Nombre")) {
                      TextField("Nombre", text: $viewModel.sale.name).foregroundColor(.black)
                  }
                    Section(header: Text("Pieces")) {
                        TextField("Pieces", text: $viewModel.sale.pieces).foregroundColor(.black)
                    }
                  if mode == .edit {
                    Section {
                      Button("Eliminar venta") { self.presentActionSheet.toggle() }
                        .foregroundColor(.red)
                    }
                  }
                }
                  .navigationTitle(mode == .new ? "NUEVA VENTA" : "VENTA")
                  .foregroundColor(mode == .new ? Color.white : Color.white)
                .navigationBarTitleDisplayMode(mode == .new ? .inline : .large)
                .navigationBarItems(
                  leading: cancelButton,
                  trailing: saveButton
                )
                .actionSheet(isPresented: $presentActionSheet) {
                  ActionSheet(title: Text("Estas Seguro?"),
                              buttons: [
                                .destructive(Text("Eliminar Venta"),
                                             action: { self.handleDeleteTapped() }),
                                .cancel()
                              ])
                }.scrollContentBackground(.hidden)
                  
              }
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
 
struct SaleEditView_Previews: PreviewProvider {
  static var previews: some View {
      let sale = Sale(IdA: "", idProduct: "", name: "", pieces: "")
      let SaleViewModel = SaleViewModel(sale: sale)
    return SaleEditView(viewModel: SaleViewModel, mode: .edit)
  }
}
