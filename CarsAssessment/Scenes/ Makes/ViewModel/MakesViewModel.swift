//
//  ArticlesListViewModel.swift
//  NYTimesTask
//
//  Created by AboNabih on 1/8/21.
//

import Foundation
import RxSwift
import RxCocoa

class MakesViewModel {
    // MARK: - Variables
    private let disposeBag = DisposeBag()
    var loadingState = BehaviorRelay<LoadingState>(value: .ideal)
    var makesClient = MakesClient()
    var makes = BehaviorRelay<[Make]>(value: [])
    var page = Paging(pageNum: 1, pageSize: 20)
    var totalNumber: Int = 0
    var isLoading = false
    // MARK: - Methods
    func load(isReloding: Bool = true) {
        loadingState.accept(.loading)
        makesClient.getMakees(page: page).subscribe(onNext: { [unowned self] (model) in
            self.totalNumber = model.totalNumber
            self.isLoading = page.pageNum < model.totalPages

            prepareData(makes: model.results, isReloding: isReloding)
            loadingState.accept(.loaded)
            }, onError: { _ in
                self.loadingState.accept(.loaded)
            }).disposed(by: disposeBag)
    }
    func prepareData(makes: [Make], isReloding: Bool) {
        var result = self.makes.value
        if !isReloding {
            result.append(contentsOf: makes)
        } else {
            result = makes
        }
        self.makes.accept(result)
    }
    func isLoadingIndexPath(_ indexPath: IndexPath) -> Bool {
       guard isLoading else { return false }
       return indexPath.row == makes.value.count - 1
     }
}
