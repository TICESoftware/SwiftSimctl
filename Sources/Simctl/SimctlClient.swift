import Foundation
import SimctlShared

// swiftlint:disable file_length

/// SimctlClient provides methods to trigger remote execution of simctl commands from your app on a local machine.
/// This is acchieved by opening a client-server connection and sending requests to the server
/// which in turn trigger execution of local commands on the server machine.
public class SimctlClient {
  /// Address and port to the host machine.
  ///
  /// Note: if you like to use another port here, you need to provide it
  /// when starting up the server via the `--port` flag.
  static var host: Host = .localhost(port: 8080)

  let session: URLSession
  let env: SimctlClientEnvironment

  /// Start client in a simulator environment.
  /// - Parameter simEnv: The simulator environment configuration.
  public convenience init(_ simEnv: SimulatorEnvironment) {
    self.init(environment: simEnv)
  }

  /// Start client in a given environment.
  public init(environment: SimctlClientEnvironment) {
    session = URLSession(configuration: .default)
    Self.host = environment.host
    self.env = environment
  }

  /// Request a push notification to be send to this app.
  /// - Parameters:
  ///   - notification: The notifcation payload to be send.
  ///   - completion: Result callback of the call. Use this to wait for an expectation to fulfill in a test case.
  public func sendPushNotification(_ notification: PushNotificationContent, _ completion: @escaping DataTaskCallback) {
    dataTask(.sendPushNotification(env, notification)) { result in
      completion(result)
    }
  }

  /// Request a change in privacy settings for this app.
  /// - Parameters:
  ///   - action: The privacy action to be taken
  ///   - service: The service to be addressed.
  ///   - completion: Result callback of the call. Use this to wait for an expectation to fulfill in a test case.
  public func setPrivacy(action: PrivacyAction, service: PrivacyService, _ completion: @escaping DataTaskCallback) {
    dataTask(.setPrivacy(env, action, service), completion)
  }

  /// Rename the current device to given name.
  /// - Parameters:
  ///   - newName: The new name of the device.
  ///   - completion: Result callback of the call. Use this to wait for an expectation to fulfill in a test case.
  public func renameDevice(to newName: String, _ completion: @escaping DataTaskCallback) {
    dataTask(.renameDevice(env, newName), completion)
  }

  /// Terminate the app with given app bundle identifier.
  /// - Parameters:
  ///   - appBundleIdentifier: The bundle identifier of the app to terminate.
  ///   - completion: Result callback of the call. Use this to wait for an expectation to fulfill in a test case.
  public func terminateApp(_ appBundleIdentifier: String, _ completion: @escaping DataTaskCallback) {
    dataTask(.terminateApp(env, appBundleIdentifier), completion)
  }

  /// Reset the contents and settings of the simulator
  /// - Parameters:
  ///   - completion: Result callback of the call. Use this to wait for an expectation to fulfill in a test case.
  public func erase(_ completion: @escaping DataTaskCallback) {
    dataTask(.erase(env), completion)
  }

  /// Reset the contents of simulator Keychain
  /// - Parameters:
  ///   - completion: Result callback of the call. Use this to wait for an expectation to fulfil in a test case.
  public func eraseKeychain(_ completion: @escaping DataTaskCallback) {
      dataTask(.eraseKeychain(env), completion)
  }

  /// Set the device UI appearance to given appearance
  /// - Parameters:
  ///   - appearance: The appearance - currently light or dark.
  ///   - completion: Result callback of the call. Use this to wait for an expectation to fulfill in a test case.
  public func setDeviceAppearance(_ appearance: DeviceAppearance, _ completion: @escaping DataTaskCallback) {
    dataTask(.setDeviceAppearance(env, appearance), completion)
  }

  /// Trigger iCloud sync on this device.
  /// - Parameter completion: Result callback of the call. Use this to wait for an expectation to fulfill in a test case.
  public func triggerICloudSync(_ completion: @escaping DataTaskCallback) {
    dataTask(.triggerICloudSync(env), completion)
  }

  /// Uninstall an app from this device.
  /// - Parameters:
  ///   - appBundleIdentifier: The bundle identifier of the app to uninstall.
  ///   - completion: Result callback of the call. Use this to wait for an expectation to fulfill in a test case.
  public func uninstallApp(_ appBundleIdentifier: String, _ completion: @escaping DataTaskCallback) {
    dataTask(.uninstallApp(env, appBundleIdentifier), completion)
  }

  /// Open a url.
  /// - Parameter url: URL to open.
  /// - Parameter completion: Result callback of the call. Use this to wait for an expectation to fulfill in a test case.
  public func openUrl(_ url: URL, completion: @escaping DataTaskCallback) {
    dataTask(.openURL(env, URLContainer(url: url)), completion)
  }

  public func getAppContainer(_ container: AppContainer? = nil, completion: @escaping DataTaskCallback) {
    dataTask(.getAppContainer(env, container), completion)
  }
}
