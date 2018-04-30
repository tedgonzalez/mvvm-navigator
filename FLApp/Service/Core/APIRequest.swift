import Foundation

/// All requests must conform to this protocol
public protocol APIRequest: Encodable {
	associatedtype Response: Decodable

	var path: String { get }
}
