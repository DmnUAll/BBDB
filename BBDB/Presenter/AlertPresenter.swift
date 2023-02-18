import UIKit

// MARK: - InfoAlertPresenterProtocol protocol
protocol InfoAlertPresenterProtocol: AnyObject {
    
    func showCurrentControllerInfoAlert()
    func showAboutAppAlert()
}

// MARK: - AlertPresenterProtocol protocol
protocol AlertPresenterProtocol {
    
    func show(alertModel: AlertModel)
}

// MARK: - AlertPresemterDelegate protocol
protocol AlertPresenterDelegate: AnyObject {
    
    func presentAlert(_ alert: UIAlertController)
}

// MARK: - AlertPresenter
struct AlertPresenter {
    
    // MARK: - Properties and Inintnalizers
    private weak var delegate: AlertPresenterDelegate?
    
    init (delegate: AlertPresenterDelegate) {
        self.delegate = delegate
    }
}

// MARK: - AlertPresenterProtocol
extension AlertPresenter: AlertPresenterProtocol {
    
    func show(alertModel: AlertModel) {
        let alert = UIAlertController(
            title: alertModel.title,
            message: alertModel.message,
            preferredStyle: .alert)
        let action = UIAlertAction(title: alertModel.buttonText, style: .default, handler: alertModel.completionHandler)
        alert.addAction(action)
        delegate?.presentAlert(alert)
    }
}
