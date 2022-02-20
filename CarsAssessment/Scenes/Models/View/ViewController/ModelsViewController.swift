//
//  ModelsViewController.swift
//  CarsAssessment
//
//  Created by AboNabih on 2/18/22.
//

import UIKit
import RxSwift
class ModelsViewController: UIViewController, Storyboarded {

    // MARK: - Variables
    let viewModel = ModelsViewModel()
    let disposeBag = DisposeBag()
    weak var coordinator: MainCoordinator?
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    // MARK: - View lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupAppearance()
        resgisteringNibfiles()
        setupRxBindings()
        viewModel.load()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension ModelsViewController {
    // MARK: - Methods
    func setupAppearance() {
        self.title = "Select Model"
    }
    func resgisteringNibfiles() {
        tableView.registerNib(cell: ModelsCell.self)
    }
    func setupRxBindings() {
        viewModel.loadingState.observe(on: MainScheduler.asyncInstance).subscribe(onNext: { [weak self] (state) in
            guard let self = self else {return}
            switch state {
            case .ideal:break
            case .loaded:
                self.activityIndicator.stopAnimating()
            case .loading:
                self.activityIndicator.startAnimating()
            case .error:
                self.showAlert( msg: "no models available") {
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }).disposed(by: disposeBag)
        tableView
            .rx.setDelegate(self)
            .disposed(by: disposeBag)
        viewModel.models
            .bind(to: tableView.rx.items(cellIdentifier: "ModelsCell",
                                         cellType: ModelsCell.self)) { (_, element, cell) in
                cell.bind(ModelsCellViewModel(item: element))
            }
            .disposed(by: disposeBag)
    }

}
extension ModelsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard viewModel.isLoadingIndexPath(indexPath) else { return }
        self.viewModel.page.pageNum += 1
        self.viewModel.load(isReloding: false)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        200
    }
}
