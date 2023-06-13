import SwiftUI
 
struct ProductDetailsView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var presentEditUserSheet = false
     
    var product: Products
     
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
                      Text("Name: \(product.name)")
                        Text("Description: \(product.description)")
                      Text("Cost: \(product.cost)")
                      Text("Price: \(product.price)")
                      Text("Units: \(product.units)")
                      Text("Utility: \(product.utility)")
                  }
                   
                }
                .navigationBarTitle("Datos de \(product.name)")
                .navigationBarItems(trailing: editButton {
                  self.presentEditUserSheet.toggle()
                })
                .onAppear() {
                  print("ProductDetailsView.onAppear() for \(self.product.name)")
                }
                .onDisappear() {
                  print("ProductDetailsView.onDisappear()")
                }
                .sheet(isPresented: self.$presentEditUserSheet) {
                    ProductEditView(viewModel: ProductViewModel(product: product), mode: .edit) { result in
                    if case .success(let action) = result, action == .delete {
                      self.presentationMode.wrappedValue.dismiss()
                    }
                  }
                }
            }.scrollContentBackground(.hidden)
        }
      
    }
     
  }
