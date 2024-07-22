import Foundation

public protocol SimctlClientEnvironment {
  var host: SimctlClient.Host { get }
  var bundleIdentifier: String? { get }
  var deviceUdid: UUID { get }
}
