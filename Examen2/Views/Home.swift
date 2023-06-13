
import SwiftUI

struct Home: View {
    @State private var activeTab: Tab = .home
    /// For smooth Shape Sliding Effect use Matched Geometry Effect
    @Namespace private var animation
    var body: some View {
        VStack(spacing: 0) {
            TabView(selection: $activeTab){
                Menu()
                    .tag(Tab.home)
                    // Hiding Native Bar
                    .toolbar(.hidden, for: .tabBar)
                SaleList()
                    .tag(Tab.services)
                    // Hiding Native Bar
                PurchaseList()
                    .tag(Tab.partners)
                    // Hiding Native Bar
                    .toolbar(.hidden, for: .tabBar)
                ProductList()
                    .tag(Tab.activity)
                    // Hiding Native Bar
                    .toolbar(.hidden, for: .tabBar)
                UserList()
                    .tag(Tab.products)
            }
            CustomTabBar()
        }.background(Color(hex: "#EAEFBD"))
    }
    @ViewBuilder
    func CustomTabBar(_ tint: Color = Color(hex: "#90BE6D"), _ inactiveTint: Color = .white) -> some View{
        /// Moving all the Remaining Tab Item's to Bottom
        HStack(alignment: .bottom ,spacing: 5){
            ForEach(Tab.allCases, id: \.rawValue){
                TabItem(tint: tint,
                        inactiveTint: inactiveTint,
                        tab: $0,
                        animation: animation,
                        activeTab: $activeTab
                )
            }
        }
        .padding(.horizontal,15)
        .padding(.vertical, 10)
        .background(content:{
            Rectangle()
                .fill(Color(hex: "#586a6a"))
                .ignoresSafeArea()
                /// Adding Blur + Shadow
                /// For shape Smoothing
                .shadow(color: tint.opacity(0.8), radius: 5, x:0, y: -5)
                .padding(.top,25)
        })
        ///Adding Animation
        .animation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7), value: activeTab)
    }
}
                    

struct TabItem: View {
    var tint: Color
    var inactiveTint: Color
    var tab: Tab
    var animation: Namespace.ID
    @Binding var activeTab: Tab
    
    var body: some View{
        VStack(){
            Image(systemName: tab.systemImage)
                .font(.title2)
                .foregroundColor(activeTab == tab ? .white : inactiveTint)
                /// Incresing Size for active Tab
                .frame(width: activeTab == tab ? 58 : 35, height: activeTab == tab ? 58 : 35)
                .background{
                    if activeTab == tab {
                        Circle()
                            .fill(tint.gradient)
                            .matchedGeometryEffect(id: "ACTIVETAB", in: animation)
                    }
                }
            Text(tab.rawValue)
                .font(.caption)
                .foregroundColor(activeTab == tab ? tint : .gray)
        }
        .frame(maxWidth: .infinity)
        .contentShape(Rectangle())
        .onTapGesture {
            activeTab = tab
        }
    }
    
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
