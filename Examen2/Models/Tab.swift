import SwiftUI

//Raw Value used as Tab Title
enum Tab: String, CaseIterable{
    case services = "Services"
    case partners = "Partners"
    case home = "Home"
    case activity = "Activity"
    case products = "Products"

    
    // SF Symbol Image
    var systemImage: String{
        switch self {
        case .home:
            return "house"
        case .services:
            return "envelope.open.badge.clock"
        case .partners:
            return "hand.raised"
        case .activity:
            return "bell"
        case .products:
            return "shippingbox"
        }
        
    }
    
    //Return Current Tab Index
    var index: Int{
        return Tab.allCases.firstIndex(of: self) ?? 0
    }
}
