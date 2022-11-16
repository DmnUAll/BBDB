import UIKit

final class ListController: UIViewController {
    
    private var presenter: ListPresenter?
    private var alertPresenter: AlertPresenterProtocol?
    lazy var listView: ListView = {
        let listView = ListView()
        return listView
    }()
    
    convenience init(for link: Link) {
        self.init()
        presenter = ListPresenter(viewController: self, link: link)
        alertPresenter = AlertPresenter(delegate: self)
        
        switch link {
        case .charactersList:
            self.title = "Characters List"
        case .episodesList:
            self.title = "Episodes List"
        case .nextDoorStoresList:
            self.title = "Stores List"
        case .pestControllTrucksList:
            self.title = "Trucks List"
        case .endCreditsList:
            self.title = "End Credits List"
        case .burgersOfTheDayList:
            self.title = "Burgers List"
        }
    }
    
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .bbdbBlue
        view.addSubview(listView)
        setupConstraints()
        listView.listTableView.dataSource = self
        listView.listTableView.delegate = self
    }
    
    // MARK: - Helpers

    private func setupConstraints() {
        let constraints = [
            listView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            listView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            listView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            listView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    func showNetworkError(message: String) {
        let alertModel = AlertModel(title: "Error",
                                    message: message,
                                    buttonText: "Try again",
                                    completionHandler: { [weak self] _ in
            guard let self = self else { return }
            self.presenter?.loadData()
        })
        alertPresenter?.show(alertModel: alertModel)
    }
}

    // MARK: - UITAbleViewDataSource

extension ListController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let rows = presenter?.dataList.count else { return 0}
        return rows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch presenter?.dataList[0] {
        case is CharacterModel:
            let cell = tableView.dequeueReusableCell(withIdentifier: "listCellWithImage", for: indexPath) as! ListViewCellWithImage
            cell.backgroundColor = .clear
            guard let character = presenter?.dataList[indexPath.row] as? CharacterModel else { return cell }
            cell.cellImageView.load(url: character.imageURL)
            cell.cellLabel.text = character.name
            return cell
        case is EpisodeModel:
            let cell = tableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath) as! ListViewCell
            cell.backgroundColor = .clear
            guard let episode = presenter?.dataList[indexPath.row] as? EpisodeModel else { return cell }
            cell.cellMainLabel.text = episode.name
            cell.cellAdditionLabel.text = "Season: \(episode.season) / Episode: \(episode.episode)"
            return cell
        case is StoreModel:
            let cell = tableView.dequeueReusableCell(withIdentifier: "listCellWithImage", for: indexPath) as! ListViewCellWithImage
            cell.backgroundColor = .clear
            guard let store = presenter?.dataList[indexPath.row] as? StoreModel else { return cell }
            cell.cellImageView.load(url: store.imageURL)
            cell.cellLabel.text = store.name
            return cell
        case is PestControlTruckModel:
            let cell = tableView.dequeueReusableCell(withIdentifier: "listCellWithImage", for: indexPath) as! ListViewCellWithImage
            cell.backgroundColor = .clear
            guard let truck = presenter?.dataList[indexPath.row] as? PestControlTruckModel else { return cell }
            cell.cellImageView.load(url: truck.imageURL)
            cell.cellLabel.text = truck.name
            return cell
        case is EndCreditsModel:
            let cell = tableView.dequeueReusableCell(withIdentifier: "listCellWithImage", for: indexPath) as! ListViewCellWithImage
            cell.backgroundColor = .clear
            guard let credits = presenter?.dataList[indexPath.row] as? EndCreditsModel else { return cell }
            cell.cellImageView.load(url: credits.imageURL)
            cell.cellLabel.text = "Season: \(credits.season) Episode: \(credits.episode)"
            return cell
        case is BurgerOfTheDayModel:
            let cell = tableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath) as! ListViewCell
            cell.backgroundColor = .clear
            guard let burger = presenter?.dataList[indexPath.row] as? BurgerOfTheDayModel else { return cell }
            cell.cellMainLabel.text = burger.name
            cell.cellAdditionLabel.text = "Seaseon: \(burger.season) Episode: \(burger.episode)"
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath) as! ListViewCell
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat().cornerRadiusAutoSize(divider: 8)
    }
}

    // MARK: - UITableViewDelegate

extension ListController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let dataFromSelectedRow = presenter?.dataList[indexPath.row] else { return }
        print(dataFromSelectedRow)
        let viewController = DetailedInfoController()
        if let dataFromSelectedRow = dataFromSelectedRow as? CharacterModel {
            viewController.title = "Character's Info"
            viewController.detailedInfoView.fillUI(with: dataFromSelectedRow)
            viewController.addWebButton(withLink: dataFromSelectedRow.wikiURL)
        }
        if let dataFromSelectedRow = dataFromSelectedRow as? EpisodeModel {
            viewController.title = "Episode Info"
            viewController.detailedInfoView.fillUI(with: dataFromSelectedRow)
            viewController.addWebButton(withLink: dataFromSelectedRow.wikiURL)
        }
        if let dataFromSelectedRow = dataFromSelectedRow as? StoreModel {
            viewController.title = "Store Info"
            viewController.detailedInfoView.fillUI(with: dataFromSelectedRow)
        }
        if let dataFromSelectedRow = dataFromSelectedRow as? PestControlTruckModel {
            viewController.title = "Truck Info"
            viewController.detailedInfoView.fillUI(with: dataFromSelectedRow)
        }
        if let dataFromSelectedRow = dataFromSelectedRow as? EndCreditsModel {
            viewController.title = "End Credits Info"
            viewController.detailedInfoView.fillUI(with: dataFromSelectedRow)
        }
        if let dataFromSelectedRow = dataFromSelectedRow as? BurgerOfTheDayModel {
            viewController.title = "Burger Info"
            viewController.detailedInfoView.fillUI(with: dataFromSelectedRow)
        }
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

        
        let addToFavoriteButton = UIContextualAction(style: .destructive, title: "Add to favorites") { _, _, completionHandler in
            print("Favoroite!")
            let character = self.presenter?.dataList[indexPath.row] as! CharacterModel
            let newFavorite = Character(context: CoreDataManager.context)
            newFavorite.name = character.name
            newFavorite.gender = character.gender
            newFavorite.age = character.age ?? "Unknown"
            newFavorite.hairColor = character.hairColor ?? "Undefined"
            newFavorite.occupation = character.occupation ?? "Unknown"
            newFavorite.firstEpisode = character.firstEpisode ?? "Undefined"
            newFavorite.voicedBy = character.voicedBy ?? "Undefined"
            newFavorite.imageURL = character.imageURL
            newFavorite.wikiURL = character.wikiURL
            CoreDataManager.favoritesArray.append(newFavorite)
            CoreDataManager.saveFavorites()
            completionHandler(true)
        }
        addToFavoriteButton.backgroundColor = .bbdbYellow
        addToFavoriteButton.image = UIImage(systemName: "star")
        let config = UISwipeActionsConfiguration(actions: [addToFavoriteButton])
        config.performsFirstActionWithFullSwipe = true
        return config
    }
}

// MARK: - AlertPresenterDelegate

extension ListController: AlertPresenterDelegate {
    func presentAlert(_ alert: UIAlertController) {
        present(alert, animated: true)
    }
}
