
/// Swifter makes all header field keys lowercase so we define them lowercase from the start.
public enum HeaderFieldKey: String {
  case bundleIdentifier = "bundle_identifier"
  case appBundlePath = "app_bundle_path"
  case deviceUdid = "device_udid"
  case privacyAction = "privacy_action"
  case privacyService = "privacy_service"
  case deviceName = "device_name"
  case targetBundleIdentifier = "target_bundle_identifier"
  case deviceAppearance = "device_appearance"
}
