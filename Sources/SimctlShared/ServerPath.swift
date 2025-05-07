import Foundation

public enum ServerPath: String {
  case pushNotification = "/simctl/pushNotification"
  case privacy = "/simctl/setPrivacy"
  case renameDevice = "/simctl/renameDevice"
  case terminateApp = "/simctl/terminateApp"
  case erase = "/simctl/erase"
  case eraseKeychain = "/simctl/eraseKeychain"
  case deviceAppearance = "/simctl/setDeviceAppearance"
  case iCloudSync = "/simctl/iCloudSync"
  case installApp = "/simctl/installApp"
  case uninstallApp = "/simctl/uninstallApp"
  case openURL = "/simctl/openUrl"
  case getAppContainer = "/simctl/getAppContainer"
}
