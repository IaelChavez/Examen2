//Les faltaba esto
import SwiftUI
struct ClienteList: View {
     
    @StateObject var viewModel = ClientesViewModel()
    @State var presentAddClienteSheet = false
     
     
    private var addButton: some View {
      Button(action: { self.presentAddClienteSheet.toggle() }) {
        Image(systemName: "plus")
      }
    }
     
    private func clienteRowView(cliente: Clientes) -> some View {
        NavigationLink(destination: ClienteDetailsView(cliente: cliente)) {
         VStack(alignment: .leading) {
             Text(cliente.name)
             .font(.headline)
           //Text(movie.description)
           //  .font(.subheadline)
            Text(cliente.lastName)
             .font(.subheadline)
         }
       }
    }
     
    var body: some View {
        ZStack {
            Color(hex: "#90BE6D")
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                NavigationView {
                    List {
                        ForEach (viewModel.clientes) { cliente in
                            clienteRowView(cliente: cliente)
                        }
                        .onDelete() { indexSet in
                            viewModel.removeClientes(atOffsets: indexSet)
                        }
                    }
                    .navigationBarTitle("Clientes")
                    .navigationBarItems(trailing: addButton)
                    .onAppear() {
                        print("MoviesListView appears. Subscribing to data updates.")
                        self.viewModel.subscribe()
                    }
                    .sheet(isPresented: self.$presentAddClienteSheet) {
                        ClienteEditView() //MovieEditView.swift
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
 
struct ClienteList_Previews: PreviewProvider {
    static var previews: some View {
        ClienteList()
    }
}

