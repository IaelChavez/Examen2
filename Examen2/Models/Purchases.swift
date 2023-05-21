import Foundation
import FirebaseFirestoreSwift
 
struct Purchases: Identifiable, Codable {
  @DocumentID var id: String?
  var cant: String
  var idC: String
  var idProduct: String
  var idV: String
  var name: String
  var pieces: String
  var subtotal: String
  var total: String
   
  enum CodingKeys: String, CodingKey {
    case cant
    case idC
    case idProduct
    case idV
    case name
    case pieces
    case subtotal
    case total
  }
}
