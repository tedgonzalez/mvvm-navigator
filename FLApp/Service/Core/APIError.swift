import Foundation

public enum APIError: Error {
    case encoding
    case decoding
    case server(message: String)
}
