//
//  ModelsRouter+Extensions.swift
//  CarsAssessment
//
//  Created by AboNabih on 2/18/22.
//

import Moya

extension ModelsRouter: TargetType {
    var path: String {
        switch self {
        case .getModels:
            return "vehicle/v3/models"
        case .getModelsPhotos(let model):
            return "media/v2/\(model.makeNiceName ?? "")/\(model.niceName ?? "")/photos"
        }
    }
    var method: Method {
        switch self {
        case .getModels:
            return .get
        case .getModelsPhotos:
            return .get
        }
    }
    var task: Task {
        switch self {
        case .getModels(let page, let makeNiceName):
            let params = ["api_key": Constants.APIS.APIKEY, "pageNum": page.pageNum, "pageSize": page.pageSize, "makeNiceName": makeNiceName] as [String: Any]
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        case .getModelsPhotos:
            let params = ["api_key": Constants.APIS.APIKEY]
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        }
    }
}
