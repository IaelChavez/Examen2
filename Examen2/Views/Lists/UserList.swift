//Les faltaba esto
import SwiftUI
struct UserList: View {
     
    @StateObject var viewModel = UsersViewModel()
    @State var presentAddUserSheet = false
     
     
    private var addButton: some View {
      Button(action: { self.presentAddUserSheet.toggle() }) {
        Image(systemName: "plus")
      }
    }
     
    private func userRowView(user: Users) -> some View {
        NavigationLink(destination: UserDetailsView(user: user)) {
         VStack(alignment: .leading) {
             Text(user.name)
             .font(.headline)
           //Text(movie.description)
           //  .font(.subheadline)
            Text(user.lastName)
             .font(.subheadline)
         }
       }
    }
     
    var body: some View {
          ZStack{
              LinearGradient(gradient: Gradient(colors: [.blue, .green,
                      .yellow]), startPoint: .topLeading, endPoint:
                      .bottomTrailing) .edgesIgnoringSafeArea(.all)
                  .scrollContentBackground(.hidden)
              VStack{
                  List {
                      ForEach (viewModel.users) { user in
                      userRowView(user: user)
                    }
                    .onDelete() { indexSet in
                      viewModel.removeUsers(atOffsets: indexSet)
                    }
                  }
                  .navigationBarTitle("Usuarios")
                  
                  .navigationBarItems(trailing: addButton)
                  .onAppear() {
                    print("MoviesListView appears. Subscribing to data updates.")
                    self.viewModel.subscribe()
                  }
                  .sheet(isPresented: self.$presentAddUserSheet) {
                      UserEditView() //MovieEditView.swift
                  }
              }.scrollContentBackground(.hidden)
          }
    }// End Body
}
 
struct UserList_Previews: PreviewProvider {
    static var previews: some View {
        UserList()
    }
}

