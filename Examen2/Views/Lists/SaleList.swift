import SwiftUI

struct SaleList: View {

@StateObject var viewModel = SalesViewModel()
@State var presentAddSaleSheet = false
 
 
private var addButton: some View {
  Button(action: { self.presentAddSaleSheet.toggle() }) {
    Image(systemName: "plus")
  }
}
 
private func userRowView(sale: Sale) -> some View {
    NavigationLink(destination: SaleDetailsView(sale: sale)) {
     VStack(alignment: .leading) {
         Text(sale.name)
         .font(.headline)
     }
   }
}
 
var body: some View {
      ZStack{
          LinearGradient(gradient: Gradient(colors: [.blue, .green,
          .yellow]), startPoint: .topLeading, endPoint:
                  .bottomTrailing) .edgesIgnoringSafeArea(.all)
          VStack{
              List {
                  ForEach (viewModel.sales) { sale in
                  userRowView(sale: sale)
                }
                .onDelete() { indexSet in
                    viewModel.removeSales(atOffsets: indexSet)
                }
              }
              .navigationBarTitle("Ventas")
              .navigationBarItems(trailing: addButton)
              .onAppear() {
                print("SalesListView appears. Subscribing to data updates.")
                self.viewModel.subscribe()
              }
              .sheet(isPresented: self.$presentAddSaleSheet) {
                  SaleEditView() //MovieEditView.swift
              }
          }.scrollContentBackground(.hidden)
      }
}// End Body
}

struct SaleList_Previews: PreviewProvider {
static var previews: some View {
    SaleList()
}
}

