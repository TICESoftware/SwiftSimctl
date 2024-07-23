import Foundation

public enum AppContainer: Codable {
  case app
  case data
  case groups
  case groupIdentifier(String)
  
  public var container: String {
    switch self {
    case .app:
      return "app"
    case .data:
      return "data"
    case .groups:
      return "groups"
    case let .groupIdentifier(groupId):
      return groupId
    }
  }
  
  enum Keys: String, CodingKey {
    case key
    case value
  }
  
  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: Keys.self)
    let key = try container.decode(String.self, forKey: .key)
    switch key {
    case "app":
      self = .app
    case "data":
      self = .data
    case "groups":
      self = .groups
    case "groupID":
      let groupID = try container.decode(String.self, forKey: .value)
      self = .groupIdentifier(groupID)
      
    default:
      throw DecodingError.dataCorrupted(.init(codingPath: decoder.codingPath, debugDescription: "Unexpected key \(key)", underlyingError: nil))
    }
  }
  
  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: Keys.self)
    switch self {
    case .app:
      try container.encode("app", forKey: .key)
      
    case .data:
      try container.encode("data", forKey: .key)
      
    case .groups:
      try container.encode("groups", forKey: .key)
      
    case .groupIdentifier(let groupID):
      try container.encode("groupID", forKey: .key)
      try container.encode(groupID, forKey: .value)
    }
  }
}
