import SwiftUI
 
enum ModeSales {
  case new
  case edit
}
 
enum ActionSales {
  case delete
  case done
  case cancel
}
 
struct SalesEditView: View {
    @Environment(\.presentationMode) private var presentationMode
    @State var presentActionSheet = false
     
    @ObservedObject var viewModel = SalesViewModel()
    var mode: ModeSales = .new
    var completionHandler: ((Result<ActionSales, Error>) -> Void)?
     
     
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
              Color(hex: "#ccd85e")
 .edgesIgnoringSafeArea(.all)
              VStack{
                  Form {
                  Section(header: Text("idClient").foregroundColor(.black)) {
                      TextField("idClient", text: $viewModel.sale.idClient).foregroundColor(.black)
                  }

                    Section(header: Text("idFerret").foregroundColor(.black)) {
                        TextField("idFerret", text: $viewModel.sale.idFerret).foregroundColor(.black)
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
 
struct SalesEditView_Previews: PreviewProvider {
  static var previews: some View {
      let sale = Sales(idClient: "", idFerret: "")
      let SalesViewModel = SalesViewModel(sale: sale)
    return SalesEditView(viewModel: SalesViewModel, mode: .edit)
  }
}
