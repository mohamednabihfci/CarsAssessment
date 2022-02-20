//  ArticleCellViewModel.swift
    //  NYTimesTask
    //
    //  Created by AboNabih on 1/8/21.
    //

    import Foundation
    import RxCocoa

    class MakesCellViewModel {
        var titleTxt = BehaviorRelay<String>(value: "")
        init(item: Make) {
            titleTxt.accept(item.niceName ?? "")
        }
    }
