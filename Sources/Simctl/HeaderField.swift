import Foundation
import enum SimctlShared.HeaderFieldKey

public struct HeaderField {
  let headerField: HeaderFieldKey
  let value: String

  public init(_ headerField: HeaderFieldKey, _ string: String) {
    self.headerField = headerField
    self.value = string
  }

  public init(_ headerField: HeaderFieldKey, _ bool: Bool) {
    self.headerField = headerField
    self.value = String(bool)
  }

  public init(_ headerField: HeaderFieldKey, _ int: Int) {
    self.headerField = headerField
    self.value = String(int)
  }

  public init(_ headerField: HeaderFieldKey, _ uuid: UUID) {
    self.headerField = headerField
    self.value = uuid.uuidString
  }
}

extension HeaderField: Equatable { }
