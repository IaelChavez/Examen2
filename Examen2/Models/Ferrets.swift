import Foundation
import FirebaseFirestoreSwift
 
struct Ferrets: Identifiable, Codable {
  @DocumentID var id: String?
  var age: String
  var color: String
  var idSupplier: String
  var image: String
    var nationality: String
    var price: String
    var species: String
    
   
  enum CodingKeys: String, CodingKey {
    case age
    case color
    case idSupplier
    case image
    case nationality
    case price
    case species
  }
}
