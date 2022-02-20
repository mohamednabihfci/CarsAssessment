//
//  ArticleCell.swift
//  NYTimesTask
//
//  Created by AboNabih on 1/8/21.
//

import UIKit
import RxSwift

class MakesCell: UITableViewCell {
    // MARK: - Outlets
    @IBOutlet weak var titleLabel: UILabel!
    // MARK: - Variables
    private let disposeBag = DisposeBag()
    var viewModel: MakesCellViewModel? {
        didSet {
            guard let model = viewModel else {
                return
            }
            model.titleTxt.bind(to: titleLabel.rx.text).disposed(by: disposeBag)
        }
    }
    // MARK: - Method
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
extension MakesCell {
    func bind(_ model: MakesCellViewModel) {
        self.viewModel = model
    }
}
