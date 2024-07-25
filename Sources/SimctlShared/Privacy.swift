/// Some permission changes will terminate the application if running.
public enum PrivacyAction: String {
  /// Grant access without prompting. Requires bundle identifier.
  case grant
  ///  Revoke access, denying all use of the service. Requires bundle identifier.
  case revoke
  ///  Reset access, prompting on next use. Bundle identifier optional.
  case reset
}

public enum PrivacyService: String {
  /// Apply the action to all services.
  case all
  /// Allow access to calendar.
  case calendar
  /// Allow access to basic contact info.
  case contactsLimited = "contacts-limited"
  /// Allow access to full contact details.
  case contacts
  /// Allow access to location services when app is in use.
  case location
  /// Allow access to location services at all times.
  case locationAlways = "location-always"
  /// Allow adding photos to the photo library.
  case photosAdd = " photos-add"
  /// Allow full access to the photo library.
  case photos
  /// Allow access to the media library.
  case media
  /// Allow access to audio input.
  case microphone
  /// Allow access to motion and fitness data.
  case motion
  /// Allow access to reminders.
  case reminders
  /// Allow use of the app with Siri.
  case siri
}
