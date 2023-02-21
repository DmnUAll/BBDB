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
        let stackView =  UICreator.shared.makeStackView(distribution: .fillEqually, addingSpacing: 16)
        stackView.toAutolayout()
        return stackView
    }()

    private lazy var linkTextView: UITextView = UICreator.shared.makeTextViewWithLink()

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
        let uiCreator = UICreator.shared
        menuStackView.addArrangedSubview(uiCreator.makeFilledButton(
            title: "Characters",
            subtitle: "List of all characters",
            action: #selector(charactersButtonTapped),
            identifier: K.AccessibilityIdentifiers.charactersButton))
        menuStackView.addArrangedSubview(uiCreator.makeFilledButton(
            title: "Episodes",
            subtitle: "List of all episodes",
            action: #selector(episodesButtonTapped),
            identifier: K.AccessibilityIdentifiers.episodesButton))
        menuStackView.addArrangedSubview(uiCreator.makeFilledButton(
            title: "Next Door Stores",
            subtitle: "List of stores around",
            action: #selector(nextDoorStoresButtonTapped),
            identifier: K.AccessibilityIdentifiers.storesButton))
        menuStackView.addArrangedSubview(uiCreator.makeFilledButton(
            title: "Pest Control Trucks",
            subtitle: "List of all pest trucks",
            action: #selector(pestControlTrucksButtonTapped),
            identifier: K.AccessibilityIdentifiers.trucksButton))
        menuStackView.addArrangedSubview(uiCreator.makeFilledButton(
            title: "End Credits",
            subtitle: "Something from end credits",
            action: #selector(endCreditsSequenceButtonTapped),
            identifier: K.AccessibilityIdentifiers.creditsButton))
        menuStackView.addArrangedSubview(uiCreator.makeFilledButton(
            title: "Burgers Of The Day",
            subtitle: "List of all burgers names",
            action: #selector(burgersOfTheDayButtonTapped),
            identifier: K.AccessibilityIdentifiers.burgersButton))
        addSubview(menuStackView)
        addSubview(linkTextView)
    }

    private func setupConstraints() {
        let constraints = [
            linkTextView.heightAnchor.constraint(equalToConstant: 40),
            linkTextView.leadingAnchor.constraint(equalTo: leadingAnchor),
            linkTextView.trailingAnchor.constraint(equalTo: trailingAnchor),
            linkTextView.bottomAnchor.constraint(equalTo: bottomAnchor),
            menuStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            menuStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            menuStackView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
