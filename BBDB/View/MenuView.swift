import UIKit

// MARK: - MenuViewDelegate protocol
protocol MenuViewDelegate: AnyObject {
    func charactersButtonTapped()
    func episodesButtonTapped()
    func nextDoorStoresButtonTapped()
    func pestControlTrucksButtonTapped()
    func endCreditsSequenceButtonTapped()
    func burgersOfTheDayButtonTapped()
}

// MARK: - MenuView
final class MenuView: UIView {
    
    // MARK: - Properties and Initializers
    weak var delegate: MenuViewDelegate?
    
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
}

// MARK: - Helpers
extension MenuView {
    
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
        menuStackView.addArrangedSubview(makeButton(title: "Characters",
                                                    subtitle: "List of all characters",
                                                    action: #selector(charactersButtonTapped)))
        menuStackView.addArrangedSubview(makeButton(title: "Episodes",
                                                    subtitle: "List of all episodes",
                                                    action: #selector(episodesButtonTapped)))
        menuStackView.addArrangedSubview(makeButton(title: "Next Door Stores",
                                                    subtitle: "List of stores around",
                                                    action: #selector(nextDoorStoresButtonTapped)))
        menuStackView.addArrangedSubview(makeButton(title: "Pest Control Trucks",
                                                    subtitle: "List of all pest trucks",
                                                    action: #selector(pestControlTrucksButtonTapped)))
        menuStackView.addArrangedSubview(makeButton(title: "End Credits",
                                                    subtitle: "Something from end credits",
                                                    action: #selector(endCreditsSequenceButtonTapped)))
        menuStackView.addArrangedSubview(makeButton(title: "Burgers Of The Day",
                                                    subtitle: "List of all burgers names",
                                                    action: #selector(burgersOfTheDayButtonTapped)))
        addSubview(menuStackView)
    }
    
    private func setupConstraints() {
        let constraints = [
            menuStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            menuStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            menuStackView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    private func makeButton(title: String, subtitle: String, action: Selector) -> UIButton{
        
        var filled = UIButton.Configuration.filled()
        filled.buttonSize = .medium
        filled.baseBackgroundColor = .bbdbGray
        filled.baseForegroundColor = .bbdbBlack
        filled.titleAlignment = .center
        filled.title = title
        filled.attributedTitle?.font = UIFont(name: "Bob'sBurgers2", size: UIScreen.screenSize(dividedBy: 25))
        filled.subtitle = subtitle
        filled.attributedSubtitle?.font = UIFont(name: "Bob'sBurgers", size: UIScreen.screenSize(dividedBy: 40))
        let button = UIButton(configuration: filled, primaryAction: nil)
        button.layer.cornerRadius = UIScreen.screenSize(dividedBy: 70)
        button.addTarget(self, action: action, for: .touchUpInside)
        return button
    }
}
