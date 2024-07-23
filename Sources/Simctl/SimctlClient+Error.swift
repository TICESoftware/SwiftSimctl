import Foundation

extension SimctlClient {
  public enum Error: Swift.Error {
    case noHttpResponse(Route)
    case unexpectedHttpStatusCode(Route, HTTPURLResponse)
    case noData(Route, HTTPURLResponse)
    case serviceError(Swift.Error)
  }
}
