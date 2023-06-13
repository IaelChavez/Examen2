import SwiftUI
struct PurchaseList: View {
     
    @StateObject var viewModel = PurchasesViewModel()
    @State var presentAddPurchaseSheet = false
     
     
    private var addButton: some View {
      Button(action: { self.presentAddPurchaseSheet.toggle() }) {
        Image(systemName: "plus")
      }
    }
     
    private func purchaseRowView(purchase: Purchases) -> some View {
        NavigationLink(destination: PurchaseDetailsView(purchase: purchase)) {
         VStack(alignment: .leading) {
             Text(purchase.name)
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
                      ForEach (viewModel.purchases) { purchase in
                          purchaseRowView(purchase: purchase)
                    }
                    .onDelete() { indexSet in
                        viewModel.removePurchases(atOffsets: indexSet)
                    }
                  }
                  .navigationBarTitle("Purchases")
                  .navigationBarItems(trailing: addButton)
                  .onAppear() {
                    print("PurchasesListView appears. Subscribing to data updates.")
                    self.viewModel.subscribe()
                  }
                  .sheet(isPresented: self.$presentAddPurchaseSheet) {
                      PurchaseEditView() //MovieEditView.swift
                  }
              }.scrollContentBackground(.hidden)
          }
    }// End Body
}
 
struct PurchaseList_Previews: PreviewProvider {
    static var previews: some View {
        PurchaseList()
    }
}
