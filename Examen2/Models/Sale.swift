import Foundation
import FirebaseFirestoreSwift
 
struct Sale: Identifiable, Codable {
  @DocumentID var id: String?
  var IdA: String
  var idProduct: String
  var name: String
  var pieces: String
   
  enum CodingKeys: String, CodingKey {
    case IdA
    case idProduct
    case name
    case pieces
  }
}
