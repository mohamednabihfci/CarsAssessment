//
//  ModelClient.swift
//  CarsAssessment
//
//  Created by AboNabih on 2/18/22.
//

import Foundation
import RxSwift

class ModelsClient: APIClient<ModelsRouter> {
    func getModels(page: Paging, makeNiceName: String) -> Observable<Models> {
           return Observable.create { (observer) -> Disposable in
            self.performRequest(route: .getModels(page: page, makeNiceName: makeNiceName), observer: observer)
               return Disposables.create()
           }.observe(on: SerialDispatchQueueScheduler(qos: .default))
       }
    func getPhotos(model: Model) -> Observable<Photos> {
           return Observable.create { (observer) -> Disposable in
            self.performRequest(route: .getModelsPhotos(model: model), observer: observer)
               return Disposables.create()
           }.observe(on: SerialDispatchQueueScheduler(qos: .default))
       }
}
