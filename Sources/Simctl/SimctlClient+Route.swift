import Foundation
import SimctlShared

extension SimctlClient {
  public enum Route {
    case sendPushNotification(SimctlClientEnvironment, PushNotificationContent)
    case setPrivacy(SimctlClientEnvironment, PrivacyAction, PrivacyService)
    case renameDevice(SimctlClientEnvironment, String)
    case terminateApp(SimctlClientEnvironment, String)
    case erase(SimctlClientEnvironment)
    case eraseKeychain(SimctlClientEnvironment)
    case setDeviceAppearance(SimctlClientEnvironment, DeviceAppearance)
    case triggerICloudSync(SimctlClientEnvironment)
    case uninstallApp(SimctlClientEnvironment, String)
    case openURL(SimctlClientEnvironment, URLContainer)
    case getAppContainer(SimctlClientEnvironment, AppContainer?)

    @inlinable var httpMethod: HttpMethod {
      switch self {
      case .sendPushNotification,
          .openURL,
          .getAppContainer:
        return .post

      case .setPrivacy,
          .renameDevice,
          .terminateApp,
          .erase,
          .eraseKeychain,
          .setDeviceAppearance,
          .triggerICloudSync,
          .uninstallApp:
        return .get
      }
    }

    @inlinable var path: ServerPath {
      switch self {
      case .sendPushNotification:
        return .pushNotification

      case .setPrivacy:
        return .privacy

      case .renameDevice:
        return .renameDevice

      case .terminateApp:
        return .terminateApp

      case .erase:
        return .erase

      case .eraseKeychain:
          return .eraseKeychain

      case .setDeviceAppearance:
        return .deviceAppearance

      case .triggerICloudSync:
        return .iCloudSync

      case .uninstallApp:
        return .uninstallApp

      case .openURL:
        return .openURL

      case .getAppContainer:
        return .getAppContainer
      }
    }

    @inlinable var headerFields: [HeaderField] {
      func setEnv(_ env: SimctlClientEnvironment) -> [HeaderField] {
        var fields: [HeaderField] = [
          .init(.deviceUdid, env.deviceUdid)
        ]
        if let bundleId = env.bundleIdentifier {
          fields.append(.init(.bundleIdentifier, bundleId))
        }
        return fields
      }

      switch self {
      case let .sendPushNotification(env, _),
        let .erase(env),
        let .eraseKeychain(env),
        let .triggerICloudSync(env),
        let .openURL(env, _),
        let .getAppContainer(env, _):
        return setEnv(env)

      case let .setPrivacy(env, action, service):
        var fields = setEnv(env)
        fields.append(HeaderField(.privacyAction, action.rawValue))
        fields.append(HeaderField(.privacyService, service.rawValue))
        return fields

      case let .renameDevice(env, name):
        var fields = setEnv(env)
        fields.append(HeaderField(.deviceName, name))
        return fields

      case let .terminateApp(env, appBundleIdentifier),
        let .uninstallApp(env, appBundleIdentifier):
        var fields = setEnv(env)
        fields.append(HeaderField(.targetBundleIdentifier, appBundleIdentifier))
        return fields

      case let .setDeviceAppearance(env, appearance):
        var fields = setEnv(env)
        fields.append(HeaderField(.deviceAppearance, appearance.rawValue))
        return fields
      }
    }

    @inlinable var httpBody: Data? {
      let encoder = JSONEncoder()
      switch self {
      case let .sendPushNotification(_, notification):
        return try? encoder.encode(notification)

      case let .openURL(_, urlContainer):
        return try? encoder.encode(urlContainer)

      case let .getAppContainer(_, container):
        return try? encoder.encode(container)

      case .setPrivacy,
          .renameDevice,
          .terminateApp,
          .erase,
          .eraseKeychain,
          .setDeviceAppearance,
          .triggerICloudSync,
          .uninstallApp:
        return nil
      }
    }

    func asURL() -> URL {
      let urlString: String = SimctlClient.host.host + path.rawValue
      guard let url = URL(string: urlString) else {
        fatalError("no valid url \(urlString)")
      }

      return url
    }

    func asURLRequest() -> URLRequest {
      var request = URLRequest(url: asURL())

      request.httpMethod = httpMethod.rawValue

      for field in headerFields {
        request.addValue(field.value, forHTTPHeaderField: field.headerField.rawValue)
      }

      request.httpBody = httpBody

      return request
    }
  }
}
