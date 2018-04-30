import Foundation

public struct GetAds: APIRequest {
    public typealias Response = AdContainer
    public var path: String {
        return "3799feea005ed49942dcb56386ecec2b/raw/63249144485884d279d55f4f3907e37098f55c74/discover.json"
    }
}
