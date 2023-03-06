import UIKit

// MARK: - SettingsViewDelegate protocol
protocol SettingsViewDelegate: AnyObject {
    func soundStateChanged(to state: Bool)
    func volumeValueChanged(to value: Float)
    func splashStateChanged(to state: Bool)
    func clearKFCache()
}

// MARK: - SettingsView
final class SettingsView: UIView {

    // MARK: - Properties and Initializers
    weak var delegate: SettingsViewDelegate?

    private let settingsStackView: UIStackView = {
        let stackView = UICreator.shared.makeStackView(addingSpacing: 30)
        stackView.toAutolayout()
        return stackView
    }()

    private lazy var settingsSoundSwitch: UISwitch = UICreator.shared.makeSwitch(
        withAction: #selector(soundSwitchStateChanged),
        andCurrentState: UserDefaultsManager.shared.appSound)

    private let settingsSoundSlider: UISlider = {
        let slider = UISlider()
        slider.toAutolayout()
        slider.value = UserDefaultsManager.shared.appVolume
        slider.addTarget(nil, action: #selector(sliderValueChanged), for: UIControl.Event.valueChanged)
        slider.minimumValue = 0
        slider.maximumValue = 1
        slider.thumbTintColor = .bbdbWhite
        slider.minimumTrackTintColor = .bbdbBlack
        slider.accessibilityIdentifier = K.AccessibilityIdentifiers.volumeSlider
        return slider
    }()

    private lazy var settingsSplashScreenSwitch: UISwitch = UICreator.shared.makeSwitch(
        withAction: #selector(splashScreenSwitchStateChanged),
        andCurrentState: UserDefaultsManager.shared.appSplashScreen)

    private let settingsClearCacheButton: UIButton = UICreator.shared.makeFilledButton(
        title: String.buttonTitle,
        subtitle: String.buttonSubtitle,
        backgroundColor: .bbdbBlack,
        foregroundColor: .bbdbGray,
        action: #selector(clearCacheButtonTapped),
        identifier: K.AccessibilityIdentifiers.clearCacheButton)

    private lazy var linkTextView: UITextView = UICreator.shared.makeTextViewWithLink()

    override init(frame: CGRect) {
        super.init(frame: frame)
        toAutolayout()
        addSubviews()
        setupConstraints()
        settingsSoundSwitch.accessibilityIdentifier = K.AccessibilityIdentifiers.soundSwitch
        settingsSplashScreenSwitch.accessibilityIdentifier = K.AccessibilityIdentifiers.splashSwitch
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Helpers
extension SettingsView {
    @objc private func clearCacheButtonTapped() {
        delegate?.clearKFCache()
    }

    @objc private func soundSwitchStateChanged() {
        delegate?.soundStateChanged(to: settingsSoundSwitch.isOn)
    }

    @objc private func sliderValueChanged() {
        delegate?.volumeValueChanged(to: settingsSoundSlider.value)
    }

    @objc private func splashScreenSwitchStateChanged() {
        delegate?.splashStateChanged(to: settingsSplashScreenSwitch.isOn)
    }

    private func addSubviews() {
        addSubview(settingsStackView)

        let soundStack = UICreator.shared.makeStackView(axis: .horizontal, alignment: .center)
        soundStack.addArrangedSubview(makeLabel(withText: String.sound))
        soundStack.addArrangedSubview(settingsSoundSwitch)
        settingsStackView.addArrangedSubview(soundStack)

        let volumeStack = UICreator.shared.makeStackView(axis: .horizontal)
        volumeStack.addArrangedSubview(makeLabel(withText: String.volume))
        volumeStack.addArrangedSubview(settingsSoundSlider)
        settingsStackView.addArrangedSubview(volumeStack)

        let splashScreenStack = UICreator.shared.makeStackView(axis: .horizontal, alignment: .center)
        splashScreenStack.addArrangedSubview(makeLabel(withText: String.showSplashScreen))
        splashScreenStack.addArrangedSubview(settingsSplashScreenSwitch)
        settingsStackView.addArrangedSubview(splashScreenStack)
        settingsStackView.addArrangedSubview(settingsClearCacheButton)
        addSubview(linkTextView)
    }

    private func setupConstraints() {
        let constraints = [
            linkTextView.heightAnchor.constraint(equalToConstant: 40),
            linkTextView.leadingAnchor.constraint(equalTo: leadingAnchor),
            linkTextView.trailingAnchor.constraint(equalTo: trailingAnchor),
            linkTextView.bottomAnchor.constraint(equalTo: bottomAnchor),
            settingsStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            settingsStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            settingsStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
        ]
        NSLayoutConstraint.activate(constraints)
    }

    private func makeLabel(withText text: String) -> UILabel {
        let label = UICreator.shared.makeLabel(text: text, font: UIFont.appFont(.filled, withSize: 26),
                                               alignment: .natural)
        label.toAutolayout()
        return label
    }
}

// MARK: - String fileprivate extension
fileprivate extension String {
    static let buttonTitle = "Clear image cache"
    static let buttonSubtitle = "Delete all images cache from memory and disk"
    static let sound = "Sound:"
    static let volume = "Volume:"
    static let showSplashScreen = "Show Splash Screen:"
}
