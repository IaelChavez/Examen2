import SwiftUI

struct SalesList: View {

@StateObject var viewModel = SalessViewModel()
@State var presentAddSalesSheet = false
 
 
private var addButton: some View {
  Button(action: { self.presentAddSalesSheet.toggle() }) {
    Image(systemName: "plus")
  }
}
 
private func salesRowView(sale: Sales) -> some View {
    NavigationLink(destination: SalesDetailsView(sale: sale)) {
     VStack(alignment: .leading) {
         Text(sale.idClient)
         .font(.headline)
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
                      ForEach (viewModel.sales) { sale in
                          salesRowView(sale: sale)
                      }
                      .onDelete() { indexSet in
                          viewModel.removeSales(atOffsets: indexSet)
                      }
                  }.background(Color(hex: "#90BE6D"))
                  .navigationBarTitle("Ventas")
                  .navigationBarItems(trailing: addButton)
                  .onAppear() {
                      print("SalesListView appears. Subscribing to data updates.")
                      self.viewModel.subscribe()
                  }
                  .sheet(isPresented: self.$presentAddSalesSheet) {
                      SalesEditView() //MovieEditView.swift
                  }
              }
              .background() // Color de fondo de la lista
              .cornerRadius(30)
              Spacer() // Agrega un espacio flexible para empujar el contenido hacia la parte superior
              
          }
          .padding() // Agrega un relleno alrededor del contenido
          
      }
  }
}


struct SalesList_Previews: PreviewProvider {
static var previews: some View {
    SalesList()
}
}

