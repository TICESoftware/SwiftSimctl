import Foundation

public struct SimulatorEnvironment: SimctlClientEnvironment {
  /// The host address and port of SimctlCLI server.
  public let host: SimctlClient.Host
  
  /// The bundle identifier of the app you want to address.
  public let bundleIdentifier: String?
  
  /// The Udid of the device or simulator you want to address.
  public let deviceUdid: UUID
  
  /// Initialize a simulator environment.
  /// - Parameters:
  ///   - host: The host and port of the SimctlCLI server.
  ///   - bundleIdentifier: The bundle identifier of the app you want to interact with.
  ///   - deviceUdid: The Udid of the device you want to interact with.
  public init(host: SimctlClient.Host, bundleIdentifier: String?, deviceUdid: UUID) {
    self.host = host
    self.bundleIdentifier = bundleIdentifier
    self.deviceUdid = deviceUdid
  }
  
  /// Initialize a simulator environment.
  /// - Parameters:
  ///   - host: The host and port of the SimctlCLI server.
  ///   - bundle: Bundle of the app you want to interact with.
  ///   - processInfo: The process info from where to get the device Udid.
  public init?(host: SimctlClient.Host, bundle: Bundle, processInfo: ProcessInfo) {
    guard let udid = Self.deviceId(processInfo) else {
      return nil
    }
    
    self.init(host: host,
              bundleIdentifier: bundle.bundleIdentifier,
              deviceUdid: udid)
  }
  
  /// Initialize a simulator environment.
  ///
  /// The device Udid of this device will be extracted from the process environment for you.
  ///
  /// - Parameters:
  ///   - bundleIdentifier: The bundle identifier of the app you want to interact with.
  ///   - host: The host and port of the SimctlCLI server.
  public init?(bundleIdentifier: String, host: SimctlClient.Host) {
    guard let udid = Self.deviceId(ProcessInfo()) else {
      return nil
    }
    self.init(host: host, bundleIdentifier: bundleIdentifier, deviceUdid: udid)
  }
  
  static func deviceId(_ processInfo: ProcessInfo) -> UUID? {
    guard let udidString = processInfo.environment[ProcessEnvironmentKey.simulatorUdid.rawValue] else {
      return nil
    }
    
    return UUID(uuidString: udidString)
  }
}
