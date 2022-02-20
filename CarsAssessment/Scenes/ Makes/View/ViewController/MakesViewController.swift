import UIKit
import RxSwift

class MakesViewController: UIViewController, Storyboarded {
    // MARK: - Variables
    let viewModel = MakesViewModel()
    let disposeBag = DisposeBag()
    weak var coordinator: MainCoordinator?
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    // MARK: - View lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAppearance()
        resgisteringNibfiles()
        setupRxBindings()
        viewModel.load()
    }
}
extension MakesViewController {
    // MARK: - Methods
    func setupAppearance() {
        self.title = "Select Make"
    }
    func resgisteringNibfiles() {
        tableView.registerNib(cell: MakesCell.self)
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
        viewModel.makes
            .bind(to: tableView.rx.items(cellIdentifier: "MakesCell",
                                         cellType: MakesCell.self)) { (_, element, cell) in
                cell.bind(MakesCellViewModel(item: element))
            }
            .disposed(by: disposeBag)
        tableView.rx.modelSelected(Make.self)
            .subscribe(onNext: { [weak self] (model) in
                self?.coordinator?.showModels(make: model)
            }).disposed(by: disposeBag)
    }

}
extension MakesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard viewModel.isLoadingIndexPath(indexPath) else { return }
        self.viewModel.page.pageNum += 1
        self.viewModel.load(isReloding: false)
    }
}
