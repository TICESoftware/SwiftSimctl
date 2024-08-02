//
//  ListDevices.swift
//
//
//  Created by Christian Treffs on 18.03.20.
//

import Foundation
import ShellOut
import SimctlShared
import Swifter

public enum ListDevicesError: Swift.Error {
  case dataConversionFailed
}

// Default Device Set
func listRegularDevices() -> [SimulatorDevice] {
  let cmd: String = "xcrun simctl list devices -v --json"
  return runListDevices(cmd)
}
// Parallel Testing Device Clones Device Set
func listClonedDevices() -> [SimulatorDevice] {
  let cmd: String = "xcrun simctl --set testing list devices -v --json"
  return runListDevices(cmd)
}

private func runListDevices(_ command: String) -> [SimulatorDevice] {
  do {
    let devicesJSONString = try shellOut(to: command)
    guard let devicesData: Data = devicesJSONString.data(using: .utf8) else {
      throw ListDevicesError.dataConversionFailed
    }
    let decoder = JSONDecoder()
    let listing = try decoder.decode(SimulatorDeviceListing.self, from: devicesData)
    return listing.devices
  } catch {
    return []
  }
}
