import SwiftUI
struct SupplierList: View {
     
    @StateObject var viewModel = SuppliersViewModel()
    @State var presentAddSupplierSheet = false
     
     
    private var addButton: some View {
      Button(action: { self.presentAddSupplierSheet.toggle() }) {
        Image(systemName: "plus")
      }
    }
     
    private func supplierRowView(supplier: Suppliers) -> some View {
        NavigationLink(destination: SupplierDetailsView(supplier: supplier)) {
         VStack(alignment: .leading) {
             Text(supplier.company)
             .font(.headline)
           //Text(movie.description)
           //  .font(.subheadline)
         }
       }
    }
     
    var body: some View {
          ZStack{
              Color(hex: "#90BE6D")
                  .edgesIgnoringSafeArea(.all)
              VStack{

                  NavigationView {
                      List {
                          ForEach (viewModel.suppliers) { supplier in
                              supplierRowView(supplier: supplier)
                          }
                          .onDelete() { indexSet in
                              viewModel.removeSuppliers(atOffsets: indexSet)
                          }
                      }.background(Color(hex: "#90BE6D"))
                      .navigationBarTitle("Suppliers")
                      .navigationBarItems(trailing: addButton)
                      .onAppear() {
                          print("SuppliersListView appears. Subscribing to data updates.")
                          self.viewModel.subscribe()
                      }
                      .sheet(isPresented: self.$presentAddSupplierSheet) {
                          SupplierEditView()                     }
                  }
                  .background() // Color de fondo de la lista
                  .cornerRadius(30)
                  Spacer() // Agrega un espacio flexible para empujar el contenido hacia la parte superior
                  
              }
              .padding() // Agrega un relleno alrededor del contenido
              
          }
      }
  }
 
struct SupplierList_Previews: PreviewProvider {
    static var previews: some View {
        SupplierList()
    }
}
