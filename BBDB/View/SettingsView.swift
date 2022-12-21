import UIKit

// MARK: - SettingsViewDelegate protocol
protocol SettingsViewDelegate: AnyObject {
    func soundStateChanged(to state: Bool)
    func volumeValueChanged(to value: Float)
}

// MARK: - WhoAmIResultView
final class SettingsView: UIView {
    
    // MARK: - Properties and Initializers
    weak var delegate: SettingsViewDelegate?
    
    private let settingsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.toAutolayout()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        return stackView
    }()
    
    let settingsSoundSwitch: UISwitch = {
        let uiSwitch = UISwitch()
        uiSwitch.toAutolayout()
        uiSwitch.isOn = UserDefaultsManager.shared.appSound
        uiSwitch.addTarget(nil, action: #selector(switchStateChanged), for: UIControl.Event.valueChanged)
        return uiSwitch
    }()
    
    private let settingsSoundSlider: UISlider = {
        let slider = UISlider()
        slider.toAutolayout()
        slider.value = UserDefaultsManager.shared.appVolume
        slider.addTarget(nil, action: #selector(sliderValueChanged), for: UIControl.Event.valueChanged)
        slider.minimumValue = 0
        slider.maximumValue = 1
        return slider
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
    
    @objc func switchStateChanged(mySwitch: UISwitch) {
        delegate?.soundStateChanged(to: settingsSoundSwitch.isOn)
    }
    
    @objc func sliderValueChanged(slider: UISlider) {
        delegate?.volumeValueChanged(to: settingsSoundSlider.value)
    }
}

// MARK: - Helpers
extension SettingsView {
    
    private func addSubviews() {
        addSubview(settingsStackView)
        
        let soundStack = makeStackView(axis: .horizontal, alignment: .center, distribution: .fill, backgroundColor: .clear)
        soundStack.addArrangedSubview(makeLabel(withText: "Sound:"))
        soundStack.addArrangedSubview(settingsSoundSwitch)
        settingsStackView.addArrangedSubview(soundStack)
        
        let volumeStack = makeStackView(axis: .vertical, alignment: .fill, distribution: .fill, backgroundColor: .clear)
        volumeStack.addArrangedSubview(makeLabel(withText: "Volume:"))
        volumeStack.addArrangedSubview(settingsSoundSlider)
        settingsStackView.addArrangedSubview(volumeStack)
    }
    
    private func setupConstraints() {
        let constraints = [
            settingsStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            settingsStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            settingsStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
            
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    private func makeStackView(axis: NSLayoutConstraint.Axis, alignment: UIStackView.Alignment, distribution: UIStackView.Distribution, backgroundColor: UIColor) -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = axis
        stackView.alignment = alignment
        stackView.distribution = distribution
        stackView.backgroundColor = backgroundColor
        stackView.spacing = 4
        return stackView
    }
    
    private func makeLabel(withText text: String) -> UILabel {
        let label = UILabel()
        label.toAutolayout()
        label.font = UIFont(name: "Bob'sBurgers", size: 26)
        label.textColor = .bbdbBlack
        label.text = text
        return label
    }
}
