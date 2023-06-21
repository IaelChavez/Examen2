import SwiftUI
 
enum ModeFerret {
  case new
  case edit
}
 
enum ActionFerret {
  case delete
  case done
  case cancel
}
 
struct FerretEditView: View {
    @Environment(\.presentationMode) private var presentationMode
    @State var presentActionSheet = false
     
    @ObservedObject var viewModel = FerretViewModel()
    var mode: ModeFerret = .new
    var completionHandler: ((Result<ActionFerret, Error>) -> Void)?
     
     
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
                    Section(header: Text("Age").foregroundColor(.black)) {
                        TextField("Age", text: $viewModel.ferret.age).foregroundColor(.black)
                    }

                      Section(header: Text("Color").foregroundColor(.black)){
                          TextField("Color", text: $viewModel.ferret.color).foregroundColor(.black)
                      }
                     
                    Section(header: Text("IdSupplier").foregroundColor(.black)) {
                        TextField("IdSupplier", text: $viewModel.ferret.idSupplier).foregroundColor(.black)
                    }
                      Section(header: Text("Image").foregroundColor(.black)) {
                          TextField("Image", text: $viewModel.ferret.image).foregroundColor(.black)
                      }
                      Section(header: Text("Nationality").foregroundColor(.black)) {
                          TextField("Nationality", text: $viewModel.ferret.nationality).foregroundColor(.black)
                      }
                      Section(header: Text("Price").foregroundColor(.black)) {
                          TextField("Price", text: $viewModel.ferret.species).foregroundColor(.black)
                      }
                    if mode == .edit {
                      Section {
                        Button("Delete ") { self.presentActionSheet.toggle() }
                          .foregroundColor(.red)
                      }
                    }
                  }
                  .navigationTitle(mode == .new ? "New Product" : "Producto")
                  .foregroundColor(mode == .new ? Color.white : Color.white)
                  .navigationBarTitleDisplayMode(mode == .new ? .inline : .large)
                  .navigationBarItems(
                    leading: cancelButton,
                    trailing: saveButton
                  )
                  .actionSheet(isPresented: $presentActionSheet) {
                    ActionSheet(title: Text("Are you sure?"),
                                buttons: [
                                  .destructive(Text("Delete"),
                                               action: { self.handleDeleteTapped() }),
                                  .cancel()
                                ])
                  }
              }.scrollContentBackground(.hidden)
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
 
struct FerretEditView_Previews: PreviewProvider {
  static var previews: some View {
      let ferret = Ferrets(age: "", color: "", idSupplier: "", image: "", nationality: "", price: "", species: "")
      let FerretViewModel = FerretViewModel(ferret: ferret)
    return FerretEditView(viewModel: FerretViewModel, mode: .edit)
  }
}
