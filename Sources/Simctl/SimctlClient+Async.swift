import Foundation
import SimctlShared

@available(macOS 10.15, *)
public extension SimctlClient {
    
    /// Request a push notification to be send to this app.
    /// - Parameters:
    ///   - notification: The notifcation payload to be send.
    @discardableResult
    func sendPushNotification(_ notification: PushNotificationContent) async throws -> Data {
        try await withCheckedThrowingContinuation { continuation in
            sendPushNotification(notification) { result in
                continuation.resume(with: result)
            }
        }
    }
    
    /// Request a change in privacy settings for this app.
    /// - Parameters:
    ///   - action: The privacy action to be taken
    ///   - service: The service to be addressed.
    @discardableResult
    func setPrivacy(action: PrivacyAction, service: PrivacyService) async throws -> Data {
        try await withCheckedThrowingContinuation { continuation in
            setPrivacy(action: action, service: service) { result in
                continuation.resume(with: result)
            }
        }
    }
    
    /// Rename the current device to given name.
    /// - Parameters:
    ///   - newName: The new name of the device.
    @discardableResult
    func renameDevice(to newName: String) async throws -> Data {
        try await withCheckedThrowingContinuation { continuation in
            renameDevice(to: newName) { result in
                continuation.resume(with: result)
            }
        }
    }
    
    /// Reset the contents and settings of the simulator
    @discardableResult
    func erase() async throws -> Data {
        try await withCheckedThrowingContinuation { continuation in
            erase() { result in
                continuation.resume(with: result)
            }
        }
    }
    
    /// Reset the contents of simulator Keychain
    @discardableResult
    func eraseKeychain() async throws -> Data {
        try await withCheckedThrowingContinuation { continuation in
            eraseKeychain() { result in
                continuation.resume(with: result)
            }
        }
    }
    
    /// Set the device UI appearance to given appearance
    /// - Parameters:
    ///   - appearance: The appearance - currently light or dark.
    @discardableResult
    func setDeviceAppearance(_ appearance: DeviceAppearance) async throws -> Data {
        try await withCheckedThrowingContinuation { continuation in
            setDeviceAppearance(appearance) { result in
                continuation.resume(with: result)
            }
        }
    }
    
    /// Trigger iCloud sync on this device.
    @discardableResult
    func triggerICloudSync() async throws -> Data {
        try await withCheckedThrowingContinuation { continuation in
            triggerICloudSync() { result in
                continuation.resume(with: result)
            }
        }
    }
    
    /// Open a url.
    /// - Parameter url: URL to open.
    @discardableResult
    func openUrl(_ url: URL) async throws -> Data {
        try await withCheckedThrowingContinuation { continuation in
            openUrl(url) { result in
                continuation.resume(with: result)
            }
        }
    }
    
    /// Get the path of the installed app's container
    /// - Parameters:
    ///  - container:   Optionally specify the container. Simctl uses `app` when not specified.
    ///    - `.app`: The .app bundle
    ///    - `.data`: The application's data container
    ///    - `.groups`: The App Group containers
    ///    - `.groupIdentifier`: A specific App Group container
    @discardableResult
    func getAppContainer(_ container: AppContainer? = nil) async throws -> Data {
        try await withCheckedThrowingContinuation { continuation in
            getAppContainer(container) { result in
                continuation.resume(with: result)
            }
        }
    }
    
    /// Terminate the app with given app bundle identifier.
    /// - Parameters:
    ///   - appBundleIdentifier: The bundle identifier of the app to terminate.
    @discardableResult
    func terminateApp(_ bundleId: String) async throws -> Data {
        try await withCheckedThrowingContinuation { continuation in
            terminateApp(bundleId) { result in
                continuation.resume(with: result)
            }
        }
    }
    
    /// Uninstall an app from this device.
    /// - Parameters:
    ///   - appBundleIdentifier: The bundle identifier of the app to uninstall.
    @discardableResult
    func uninstallApp(_ bundleId: String) async throws -> Data {
        try await withCheckedThrowingContinuation { continuation in
            uninstallApp(bundleId) { result in
                continuation.resume(with: result)
            }
        }
    }
    
    /// Install an app from this device.
    /// - Parameters:
    ///   - path: The path to the app that should be installed.
    @discardableResult
    func installApp(_ path: String) async throws -> Data {
        try await withCheckedThrowingContinuation { continuation in
            installApp(path) { result in
                continuation.resume(with: result)
            }
        }
    }
}
