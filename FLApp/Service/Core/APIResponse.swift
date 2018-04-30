import Foundation

/// Top level response for every request
public struct APIResponse<Response: Decodable>: Decodable {
	public let data: Response?
}
