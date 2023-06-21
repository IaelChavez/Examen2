import Foundation
import FirebaseFirestoreSwift
 
struct Suppliers: Identifiable, Codable {
  @DocumentID var id: String?
  var company: String
  var email: String
  var image: String
  var lastName: String
  var name: String
   
  enum CodingKeys: String, CodingKey {
    case company
    case email
    case image
    case lastName
    case name
  }
}
