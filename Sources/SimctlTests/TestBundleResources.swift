import Foundation
import XCTest

final class MocksDummyClass {}

enum TestBundleResources: String {
  case devices = "devices"

  var filePath: String {
    let mocksPath = Bundle.mockPath
    let filePath = mocksPath + "/\(self.rawValue).json"
    return filePath
  }
}

fileprivate extension Bundle {
  static var mockPath: String {
#if os(macOS)
    let bundlePath = Bundle(for: type(of: MocksDummyClass()))
      .path(forResource: "resources", ofType: "bundle")
    return bundlePath!
#else
    let bundleURL = Bundle(for: type(of: MocksDummyClass()))
      .url(forResource: "resources", withExtension: "bundle")
    let bundlePath = bundleURL?.path
    return bundlePath!
#endif
  }
}
