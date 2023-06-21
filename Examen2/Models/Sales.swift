import Foundation
import FirebaseFirestoreSwift
 
struct Sales: Identifiable, Codable {
  @DocumentID var id: String?
  var idClient: String
  var idFerret: String

   
  enum CodingKeys: String, CodingKey {
    case idClient
    case idFerret
  }
}
