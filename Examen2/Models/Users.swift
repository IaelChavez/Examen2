import Foundation
import FirebaseFirestoreSwift
 
struct Users: Identifiable, Codable {
  @DocumentID var id: String?
  var age: String
  var email: String
  var gender: String
  var lastName: String
  var name: String
  var password: String
   
  enum CodingKeys: String, CodingKey {
    case age
    case email
    case gender
    case lastName
    case name
    case password
  }
}
