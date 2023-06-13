import Foundation
import FirebaseFirestoreSwift
 
struct Products: Identifiable, Codable {
  @DocumentID var id: String?
  var cost: String
  var description: String
  var name: String
  var price: String
  var units: String
  var utility: String
   
  enum CodingKeys: String, CodingKey {
    case id
    case cost
    case description
    case name
    case price
    case units
    case utility
  }
}
