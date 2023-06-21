//Les faltaba esto
import SwiftUI
struct FerretList: View {
     
    @StateObject var viewModel = FerretsViewModel()
    @State var presentAddFerretsSheet = false
     
     
    private var addButton: some View {
      Button(action: { self.presentAddFerretsSheet.toggle() }) {
        Image(systemName: "plus")
      }
    }
     
    private func ferretRowView(ferret: Ferrets) -> some View {
        NavigationLink(destination: FerretDetailsView(ferret: ferret)) {
         VStack(alignment: .leading) {
             Text(ferret.age)
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
                      ForEach (viewModel.ferrets) { ferret in
                          ferretRowView(ferret: ferret)
                    }
                    .onDelete() { indexSet in
                        viewModel.removeFerrets(atOffsets: indexSet)
                    }
                  }.background(Color(hex: "#90BE6D"))
                  .navigationBarTitle("Ferrets")
                  .navigationBarItems(trailing: addButton)
                  .onAppear() {
                    print("FerretListView appears. Subscribing to data updates.")
                    self.viewModel.subscribe()
                  }
                  .sheet(isPresented: self.$presentAddFerretsSheet) {
                      FerretEditView() //MovieEditView.swift
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
 
struct FerretListList_Previews: PreviewProvider {
    static var previews: some View {
        FerretList()
    }
}

