//
//  ModelsCell.swift
//  CarsAssessment
//
//  Created by AboNabih on 2/18/22.
//

import UIKit
import RxSwift
import Nuke

class ModelsCell: UITableViewCell {
    // MARK: - Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var backgroundImg: UIImageView!
    // MARK: - Variables
    private let disposeBag = DisposeBag()
    var viewModel: ModelsCellViewModel? {
        didSet {
            guard let model = viewModel else {
                return
            }
            model.titleTxt.bind(to: titleLabel.rx.text).disposed(by: disposeBag)
            model.backgroundImg.observe(on: MainScheduler.asyncInstance).subscribe(onNext: { [weak self] (url) in
                guard let self = self else {return}
                Nuke.loadImage(with: url, into: self.backgroundImg)

            }).disposed(by: disposeBag)
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
extension ModelsCell {
    func bind(_ model: ModelsCellViewModel) {
        self.viewModel = model
    }
}
