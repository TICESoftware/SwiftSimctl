import Foundation

public struct URLContainer: Codable {
  public let url: URL

  public init(url: URL) {
    self.url = url
  }
}
