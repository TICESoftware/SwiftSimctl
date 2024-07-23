//
//  SimctlShared.swift
//
//
//  Created by Christian Treffs on 18.03.20.
//

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
  case uninstallApp = "/simctl/uninstallApp"
  case openURL = "/simctl/openUrl"
  case getAppContainer = "/simctl/getAppContainer"
}
