import Foundation

public enum PushNotificationContent {
  /// Path to a push payload .json/.apns file.
  ///
  /// The file must reside on the host machine!
  /// The file must be a JSON file with a valid Apple Push Notification Service payload, including the “aps” key.
  /// It must also contain a top-level “Simulator Target Bundle” with a string value
  /// that matches the target application‘s bundle identifier.
  case file(URL)
  
  /// Arbitrary json encoded push notification payload.
  ///
  /// The payload must be JSON with a valid Apple Push Notification Service payload, including the “aps” key.
  /// It must also contain a top-level “Simulator Target Bundle” with a string value
  /// that matches the target application‘s bundle identifier.
  case jsonPayload(Data)
}

extension PushNotificationContent {
  enum Keys: String, CodingKey {
    case file
    case jsonPayload
  }
}

extension PushNotificationContent: Encodable {
  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: Keys.self)
    switch self {
    case let .file(url):
      try container.encode(url, forKey: .file)
      
    case let .jsonPayload(data):
      try container.encode(data, forKey: .jsonPayload)
    }
  }
}

extension PushNotificationContent: Decodable {
  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: Keys.self)
    
    if let url = try container.decodeIfPresent(URL.self, forKey: .file) {
      self = .file(url)
    } else if let data = try container.decodeIfPresent(Data.self, forKey: .jsonPayload) {
      self = .jsonPayload(data)
    } else {
      throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "unknown case"))
    }
  }
}
