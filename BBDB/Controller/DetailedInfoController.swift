import UIKit

final class DetailedInfoController: UIViewController {
    private var presenter: DetailedInfoPresenter?
    
    lazy var detailedInfoView: DetailedInfoView = {
        let detailedInfoView = DetailedInfoView()
        return detailedInfoView
    }()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Character Info"
        view.backgroundColor = .bbdbBlue
        view.addSubview(detailedInfoView)
        setupConstraints()
        presenter = DetailedInfoPresenter()
    }
    
    // MARK: - Helpers
    
    private func setupConstraints() {
        let constraints = [
            detailedInfoView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            detailedInfoView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            detailedInfoView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            detailedInfoView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ]
        NSLayoutConstraint.activate(constraints)
    }
}

