import SimctlShared

extension SimctlClient {
    public struct Host {
        let host: String

        public init(_ host: String) {
            self.host = host
        }
    }
}
extension SimctlClient.Host {
    public static func localhost(port: SimctlShared.Port) -> SimctlClient.Host { SimctlClient.Host("http://localhost:\(port)") }
}
extension SimctlClient.Host: Equatable { }
