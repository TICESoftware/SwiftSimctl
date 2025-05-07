//
//  Commands.swift
//
//
//  Created by Christian Treffs on 17.03.20.
//

import Foundation
import ShellOut
import SimctlShared

extension ShellOutCommand {
  private static func simctlCommand(for deviceId: String) -> (String) -> String {
    let clonedDevicesList = listClonedDevices()
    if clonedDevicesList.map({ $0.deviceId }).contains(deviceId) {
      return simctlForClones(_:)
    }
    
    let regularDevicesList = listRegularDevices()
    if regularDevicesList.map({ $0.deviceId }).contains(deviceId) {
      return simctlForRegular(_:)
    }
    
    fatalError("Unexpected device ID: \(deviceId)!")
  }
  
  static func openSimulator() -> ShellOutCommand {
    .init(string: "open -b com.apple.iphonesimulator")
  }
  
  static func killAllSimulators() -> ShellOutCommand {
    .init(string: "killall Simulator")
  }
  
  private static func simctlForRegular(_ cmd: String) -> String {
    "xcrun simctl \(cmd)"
  }
  
  private static func simctlForClones(_ cmd: String) -> String {
    "xcrun simctl --set testing \(cmd)"
  }
  
  static func simctlBoot(device: UUID) -> ShellOutCommand {
    .init(string: simctlCommand(for: device.uuidString)("boot \(device.uuidString)"))
  }
  
  static func simctlShutdown(device: UUID) -> ShellOutCommand {
    .init(string: simctlCommand(for: device.uuidString)("shutdown \(device.uuidString)"))
  }
  
  static func simctlOpen(url: URL, on device: UUID) -> ShellOutCommand {
    .init(string: simctlCommand(for: device.uuidString)("openurl \(device.uuidString) \(url.absoluteString)"))
  }
  
  /// Usage: simctl ui <device> <option> [<arguments>]
  static func simctlSetUI(appearance: DeviceAppearance, on device: UUID) -> ShellOutCommand {
    .init(string: simctlCommand(for: device.uuidString)("ui \(device.uuidString) appearance \(appearance.rawValue)"))
  }
  
  /// xcrun simctl push <device> com.example.my-app ExamplePush.apns
  /// simctl push <device> [<bundle identifier>] (<json file> | -)
  static func simctlPush(to device: UUID, pushContent: PushNotificationContent, bundleIdentifier: String? = nil) -> ShellOutCommand {
    switch pushContent {
    case let .file(url):
      return .init(string: simctlCommand(for: device.uuidString)("push \(device.uuidString) \(bundleIdentifier ?? "") \(url.path)"))
      
    case let .jsonPayload(data):
      var jsonString = String(data: data, encoding: .utf8) ?? ""
      jsonString = jsonString.replacingOccurrences(of: "\n", with: "")
      return .init(string: simctlCommand(for: device.uuidString)("push \(device.uuidString) \(bundleIdentifier ?? "") - <<< '\(jsonString)'"))
    }
  }
  
  ///  simctl privacy <device> <action> <service> [<bundle identifier>]
  static func simctlPrivacy(_ action: PrivacyAction, permissionsFor service: PrivacyService, on device: UUID, bundleIdentifier: String?) -> ShellOutCommand {
    .init(string: simctlCommand(for: device.uuidString)("privacy \(device.uuidString) \(action.rawValue) \(service.rawValue) \(bundleIdentifier ?? "")"))
  }
  
  /// Rename a device.
  ///
  /// Usage: simctl rename <device> <name>
  ///
  /// - Parameters:
  ///   - device: The device Udid
  ///   - name: The new name
  static func simctlRename(device: UUID, to name: String) -> ShellOutCommand {
    .init(string: simctlCommand(for: device.uuidString)("rename \(device.uuidString) \(name)"))
  }
  
  /// Terminate an application by identifier on a device.
  ///
  /// Usage: simctl terminate <device> <app bundle identifier>
  ///
  /// - Parameters:
  ///   - device: The device Udid
  ///   - appBundleIdentifier: App bundle identifier of the app to terminate.
  static func simctlTerminateApp(device: UUID, appBundleIdentifier: String) -> ShellOutCommand {
    .init(string: simctlCommand(for: device.uuidString)("terminate \(device.uuidString) \(appBundleIdentifier)"))
  }
  
  static func simctlErase(device: UUID) -> ShellOutCommand {
    .init(string: simctlCommand(for: device.uuidString)("erase \(device.uuidString)"))
  }
  
  static func simctlEraseKeychain(device: UUID) -> ShellOutCommand {
    .init(string: simctlCommand(for: device.uuidString)("keychain \(device.uuidString) reset"))
  }
  
  /// Trigger iCloud sync on a device.
  ///
  /// Usage: simctl icloud_sync <device>
  ///
  /// - Parameter device: The device Udid
  static func simctlTriggerICloudSync(device: UUID) -> ShellOutCommand {
    .init(string: simctlCommand(for: device.uuidString)("icloud_sync \(device.uuidString)"))
  }
  
  /// Install an app from a device.
  ///
  /// Usage: simctl install <device> <path to app bundle>
  ///
  /// - Parameters:
  ///   - device: The device Udid
  ///   - appBundlePath: App bundle path (.app) of the app to install.
  static func simctlInstallApp(device: UUID, appBundlePath: String) -> ShellOutCommand {
    .init(string: simctlCommand(for: device.uuidString)("install \(device.uuidString) \(appBundlePath)"))
  }
  
  /// Uninstall an app from a device.
  ///
  /// Usage: simctl uninstall <device> <app bundle identifier>
  ///
  /// - Parameters:
  ///   - device: The device Udid
  ///   - appBundleIdentifier: App bundle identifier of the app to uninstall.
  static func simctlUninstallApp(device: UUID, appBundleIdentifier: String) -> ShellOutCommand {
    .init(string: simctlCommand(for: device.uuidString)("uninstall \(device.uuidString) \(appBundleIdentifier)"))
  }
  
  /// Install an xcappdata package to a device, replacing the current contents of the container.
  ///
  /// Usage: simctl install_app_data <device> <path to xcappdata package>
  /// This will replace the current contents of the container. If the app is currently running it will be terminated before the container is replaced.
  static func simctlInstallAppData(device: UUID, appData: URL) -> ShellOutCommand {
    .init(string: simctlCommand(for: device.uuidString)("install_app_data \(device.uuidString) \(appData.path)"))
  }
  
  /// Print the path of the installed app's container
  ///
  /// Usage: simctl get_app_container <device> <app bundle identifier> [<container>]
  ///
  /// container   Optionally specify the container. Defaults to app.
  ///     app                 The .app bundle
  ///     data                The application's data container
  ///     groups              The App Group containers
  ///     <group identifier>  A specific App Group container
  static func simctlGetAppContainer(device: UUID, appBundleIdentifier: String, container: AppContainer? = nil) -> ShellOutCommand {
    if let container = container {
      return .init(string: simctlCommand(for: device.uuidString)("get_app_container \(device.uuidString) \(appBundleIdentifier) \(container.container)"))
    } else {
      return .init(string: simctlCommand(for: device.uuidString)("get_app_container \(device.uuidString) \(appBundleIdentifier)"))
    }
  }
}

internal enum ListFilterType: String {
  case devices
  case devicetypes
  case runtimes
  case pairs
  case noFilter = ""
}
