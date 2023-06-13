//Les faltaba esto
import SwiftUI
struct ProductList: View {
     
    @StateObject var viewModel = ProductsViewModel()
    @State var presentAddProductsSheet = false
     
     
    private var addButton: some View {
      Button(action: { self.presentAddProductsSheet.toggle() }) {
        Image(systemName: "plus")
      }
    }
     
    private func productRowView(product: Products) -> some View {
        NavigationLink(destination: ProductDetailsView(product: product)) {
         VStack(alignment: .leading) {
             Text(product.name)
             .font(.headline)
           //Text(movie.description)
           //  .font(.subheadline)
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
                      ForEach (viewModel.products) { product in
                          productRowView(product: product)
                    }
                    .onDelete() { indexSet in
                        viewModel.removeProducts(atOffsets: indexSet)
                    }
                  }
                  .navigationBarTitle("Products")
                  .navigationBarItems(trailing: addButton)
                  .onAppear() {
                    print("ProductsListView appears. Subscribing to data updates.")
                    self.viewModel.subscribe()
                  }
                  .sheet(isPresented: self.$presentAddProductsSheet) {
                      ProductEditView() //MovieEditView.swift
                  }

              }.scrollContentBackground(.hidden)
          }
    }// End Body
}
 
struct ProductListList_Previews: PreviewProvider {
    static var previews: some View {
        ProductList()
    }
}

