@usableFromInline
internal enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
}
extension HttpMethod: Equatable { }
