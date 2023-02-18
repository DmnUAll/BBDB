import UIKit

// MARK: - ListView
final class ListView: UIView {
    
    // MARK: - Properties and Initializers
    let listSearchBar: UISearchBar = UICreator.shared.makeSearchBar()
    let listTableView: UITableView = UICreator.shared.makeTable(withCells: (type: ListViewCellWithImage.self, identifier: K.Identifiers.listCellWithImage), (type: ListViewCell.self, identifier: K.Identifiers.listCell))
    private let listActivityIndicator: UIActivityIndicatorView = UICreator.shared.makeActivityIndicator(withColor: .bbdbYellow)
    private lazy var linkTextView: UITextView = UICreator.shared.makeTextViewWithLink()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        toAutolayout()
        addSubviews()
        setupConstraints()
        listActivityIndicator.startAnimating()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Helpers
extension ListView {
    
    private func addSubviews() {
        addSubview(listSearchBar)
        addSubview(listTableView)
        addSubview(listActivityIndicator)
        addSubview(linkTextView)
    }
    
    private func setupConstraints() {
        let constraints = [
            linkTextView.heightAnchor.constraint(equalToConstant: 40),
            linkTextView.leadingAnchor.constraint(equalTo: leadingAnchor),
            linkTextView.trailingAnchor.constraint(equalTo: trailingAnchor),
            linkTextView.bottomAnchor.constraint(equalTo: bottomAnchor),
            listSearchBar.topAnchor.constraint(equalTo: topAnchor),
            listSearchBar.leadingAnchor.constraint(equalTo: leadingAnchor),
            listSearchBar.trailingAnchor.constraint(equalTo: trailingAnchor),
            listActivityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            listActivityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor),
            listTableView.topAnchor.constraint(equalTo: listSearchBar.bottomAnchor),
            listTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            listTableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            listTableView.bottomAnchor.constraint(equalTo: linkTextView.topAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    func fillAndReloadTable() {
        listActivityIndicator.isAnimating ? listActivityIndicator.stopAnimating() : listActivityIndicator.startAnimating()
        listTableView.reloadData()
        listTableView.isHidden.toggle()
    }
}
