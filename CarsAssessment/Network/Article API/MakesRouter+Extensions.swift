import Moya

extension MakesRouter: TargetType {
    var path: String {
        switch self {
        case .getMakes:
            return "vehicle/v3/makes"
        }
    }
    var method: Method {
        switch self {
        case .getMakes:
            return .get
        }
    }
    var task: Task {
        switch self {
        case .getMakes(let page):
            let apiKey = ["api_key": Constants.APIS.APIKEY, "pageNum": page.pageNum, "pageSize": page.pageSize] as [String: Any]
            return .requestParameters(parameters: apiKey, encoding: URLEncoding.default)
        }
    }
}
