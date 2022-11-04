import UIKit

protocol MenuViewDelegate: AnyObject {
    func aboutMenuButtonTapped()
    func aboutAppButtonTapped()
    func charactersButtonTapped()
    func episodesButtonTapped()
    func nextDoorStoresButtonTapped()
    func pestControlTrucksButtonTapped()
    func endCreditsSequenceButtonTapped()
    func burgersOfTheDayButtonTapped()
}

final class MenuView: UIView {
    
    weak var delegate: MenuViewDelegate?
    
    lazy var menuNavigationBar: UINavigationBar = {
        let navigationBar = UINavigationBar()
        navigationBar.toAutolayout()
        navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationBar.backgroundColor = .clear
        navigationBar.tintColor = .bbdbBlack
        let navigationItem = UINavigationItem(title: "Main Menu")
        navigationBar.titleTextAttributes = [.font: UIFont(name: "Bob'sBurgers", size: 30)!, .foregroundColor: UIColor.bbdbBlack]
        navigationBar.setTitleVerticalPositionAdjustment(3, for: .default)
        var menuItems: [UIAction] = [
            UIAction(title: "About Menu", image: UIImage(systemName: "clock.badge.questionmark"), handler: { [weak self] _ in
                guard let self = self else { return }
                self.delegate?.aboutMenuButtonTapped()
            }),
            UIAction(title: "About App", image: UIImage(systemName: "questionmark.app"), handler: { [weak self] _ in
                guard let self = self else { return }
                self.delegate?.aboutAppButtonTapped()
            }),
        ]
        var buttonMenu = UIMenu(title: "Info", image: nil, identifier: nil, options: [], children: menuItems)
        let infoButton = UIBarButtonItem(title: "Menu", image: UIImage(systemName: "info.circle"), primaryAction: nil, menu: buttonMenu)
        navigationItem.leftBarButtonItem = infoButton
        navigationBar.setItems([navigationItem], animated: false)
        return navigationBar
    }()
    
    private let menuStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.toAutolayout()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 16
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        toAutolayout()
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func charactersButtonTapped(tag: Int) {
        delegate?.charactersButtonTapped()
    }
    
    @objc private func episodesButtonTapped() {
        delegate?.episodesButtonTapped()
    }
    
    @objc private func nextDoorStoresButtonTapped() {
        delegate?.nextDoorStoresButtonTapped()
    }
    
    @objc private func pestControlTrucksButtonTapped() {
        delegate?.pestControlTrucksButtonTapped()
    }
    
    @objc private func endCreditsSequenceButtonTapped() {
        delegate?.endCreditsSequenceButtonTapped()
    }
    
    @objc private func burgersOfTheDayButtonTapped() {
        delegate?.burgersOfTheDayButtonTapped()
    }
    
    private func addSubviews() {
        addSubview(menuNavigationBar)
        menuStackView.addArrangedSubview(makeButton(title: "Characters",
                                                    subtitle: "List of all characters",
                                                    imageName: "person",
                                                    action: #selector(charactersButtonTapped)))
        menuStackView.addArrangedSubview(makeButton(title: "Episodes",
                                                    subtitle: "List of all episodes",
                                                    imageName: "film",
                                                    action: #selector(episodesButtonTapped)))
        menuStackView.addArrangedSubview(makeButton(title: "Next Door Stores",
                                                    subtitle: "List of stores around",
                                                    imageName: "house.and.flag",
                                                    action: #selector(nextDoorStoresButtonTapped)))
        menuStackView.addArrangedSubview(makeButton(title: "Pest Control Trucks",
                                                    subtitle: "List of all pest trucks",
                                                    imageName: "box.truck",
                                                    action: #selector(pestControlTrucksButtonTapped)))
        menuStackView.addArrangedSubview(makeButton(title: "End Credits",
                                                    subtitle: "Something from end credits",
                                                    imageName: "text.aligncenter",
                                                    action: #selector(endCreditsSequenceButtonTapped)))
        menuStackView.addArrangedSubview(makeButton(title: "Burgers Of The Day",
                                                    subtitle: "List of all burgers names",
                                                    imageName: "fork.knife.circle",
                                                    action: #selector(burgersOfTheDayButtonTapped)))
        addSubview(menuStackView)
    }
    
    private func setupConstraints() {
        let constraints = [
            menuNavigationBar.topAnchor.constraint(equalTo: topAnchor),
            menuNavigationBar.leadingAnchor.constraint(equalTo: leadingAnchor),
            menuNavigationBar.trailingAnchor.constraint(equalTo: trailingAnchor),
            menuStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            menuStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
            menuStackView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}

extension MenuView {
    
    private func makeButton(title: String, subtitle: String, imageName: String, action: Selector) -> UIButton{
        
        var filled = UIButton.Configuration.filled()
        filled.buttonSize = .medium
        filled.baseBackgroundColor = .bbdbGray
        filled.baseForegroundColor = .bbdbBlack
        filled.titleAlignment = .automatic
        filled.title = title
        filled.attributedTitle?.font = UIFont(name: "Bob'sBurgers2", size: CGFloat().textAutoSize(divider: 30))
        filled.subtitle = subtitle
        filled.attributedSubtitle?.font = UIFont(name: "Bob'sBurgers", size: CGFloat().textAutoSize(divider: 50))
        filled.image = UIImage(systemName: imageName)
        filled.imagePlacement = .leading
        filled.imagePadding = 8
        let button = UIButton(configuration: filled, primaryAction: nil)
        button.layer.cornerRadius = CGFloat().cornerRadiusAutoSize(divider: 70)
        button.addTarget(self, action: action, for: .touchUpInside)
        return button
    }
}
