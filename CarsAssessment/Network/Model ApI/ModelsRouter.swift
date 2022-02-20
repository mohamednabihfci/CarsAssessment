//
//  ModelRouter.swift
//  CarsAssessment
//
//  Created by AboNabih on 2/18/22.
//

import Foundation
enum ModelsRouter {
    case getModels(page: Paging, makeNiceName: String)
    case getModelsPhotos(model: Model)
}
