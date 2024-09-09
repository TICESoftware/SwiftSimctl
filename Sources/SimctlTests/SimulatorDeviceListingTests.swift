import Foundation
import XCTest
@testable import SimctlShared

final class SimulatorDeviceListingTests: XCTestCase {

  func test_deviceListing_decodesCorrectly() throws {
    let sutType = SimulatorDeviceListing.self
    
    let jsonPath = TestBundleResources.devices.filePath
    let str = try String(contentsOfFile: jsonPath)
    let sut = try JSONDecoder().decode(sutType, from: str.data(using: .utf8)!)
    XCTAssertEqual(sut.devices.count, 46)
  }
}

