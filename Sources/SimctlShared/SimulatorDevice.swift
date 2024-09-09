import Foundation

public struct SimulatorDeviceListing {
  public enum Keys: String, CodingKey {
    case devices
  }

  public let devices: [SimulatorDevice]
}

extension SimulatorDeviceListing: Decodable {
  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: Keys.self)
    let dict = try container.decode([String: [SimulatorDevice]].self, forKey: .devices)
    self.devices = dict.values.flatMap { $0 }
  }
}

public struct SimulatorDevice: Decodable {
  public let udid: UUID
  public let name: String
  public let isAvailable: Bool
  public let deviceTypeIdentifier: String?
  public let state: State
  public let logPath: URL
  public let dataPath: URL
}
public extension SimulatorDevice {
  var deviceId: String {
    udid.uuidString
  }

  var description: String {
    "<SimulatorDevice[\(deviceId)]: \(name) (\(state))>"
  }
}

extension SimulatorDevice {
  public enum State: String, Decodable {
    case shutdown = "Shutdown"
    case booted = "Booted"
  }
}

