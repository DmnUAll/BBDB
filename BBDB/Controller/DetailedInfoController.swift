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
        view.backgroundColor = .bbdbBlue
        view.addSubview(detailedInfoView)
        setupConstraints()
    }
    
    func addWebButton(withLink link: String) {
        presenter = DetailedInfoPresenter(viewController: self)
        presenter?.link = link
        print(link)

        let webButton = UIBarButtonItem(image: UIImage(systemName: "network"), style: .plain, target: self, action: #selector(webButtonTapped))
        navigationItem.rightBarButtonItem = webButton
    }
    
    @objc func webButtonTapped() {
        presenter?.webButtonTapped()
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

