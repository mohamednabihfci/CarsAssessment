//
//  ModelsViewModel.swift
//  CarsAssessment
//
//  Created by AboNabih on 2/18/22.
//

import Foundation
import RxSwift
import RxCocoa

class ModelsViewModel {
    // MARK: - Variables
    private let disposeBag = DisposeBag()
    var loadingState = BehaviorRelay<LoadingState>(value: .ideal)
    var modelsClient = ModelsClient()
    var make: Make!
    var models = BehaviorRelay<[Model]>(value: [])
    var page = Paging(pageNum: 1, pageSize: 20)
   // let showLoading = BehaviorRelay<Bool>(value: false)
    var totalNumber: Int = 0
    var isLoading = false
    // MARK: - Methods
    func load(isReloding: Bool = true) {
        loadingState.accept(.loading)
        modelsClient.getModels(page: page, makeNiceName: make.niceName ?? "").subscribe(onNext: { [unowned self] (model) in
            self.totalNumber = model.totalNumber
            self.isLoading = page.pageNum < model.totalPages

            prepareData(makes: model.results, isReloding: isReloding)
            loadingState.accept(.loaded)
            }, onError: { _ in
                self.loadingState.accept(.loaded)
            }).disposed(by: disposeBag)
    }
    func prepareData(makes: [Model], isReloding: Bool) {
        var result = self.models.value
        if !isReloding {
            result.append(contentsOf: makes)
        } else {
            result = makes
        }
        self.models.accept(result)
    }
    func isLoadingIndexPath(_ indexPath: IndexPath) -> Bool {
       guard isLoading else { return false }
       return indexPath.row == models.value.count - 1
     }
}
