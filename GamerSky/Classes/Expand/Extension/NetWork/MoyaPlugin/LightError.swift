
import Moya

public struct LightError: Error {
    
    public var code: String
    public var reason: String
}

extension Error {
    
    var errorMessage: String {

        guard let error = self as? MoyaError else {return "未知错误"}
        
        switch error {
        case let .underlying(underlyingError, _):
            
            if let underlyingError = underlyingError as? LightError {
                return underlyingError.reason
            }
        default:
            break
        }
        return "未知错误"
    }
}
