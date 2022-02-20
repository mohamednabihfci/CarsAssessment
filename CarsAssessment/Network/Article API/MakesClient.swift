//
//  ArticleClient.swift
//  NYTimesTask
//
//  Created by AboNabih on 1/7/21.
//

import Foundation
import RxSwift

class MakesClient: APIClient<MakesRouter> {
    func getMakees(page: Paging) -> Observable<Makes> {
           return Observable.create { (observer) -> Disposable in
            self.performRequest(route: .getMakes(page: page), observer: observer)
               return Disposables.create()
           }.observe(on: SerialDispatchQueueScheduler(qos: .default))
       }
}
