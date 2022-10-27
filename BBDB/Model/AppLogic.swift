//
//  AppLogic.swift
//  BBDB
//
//  Created by Илья Валито on 20.10.2022.
//

import Foundation

protocol AppLogicDelegate: AnyObject {
    func didFailToLoadData(with error: Error)
    func didLoadDataFromServer()
    func didReceiveFeed(_ feedList: Character)
}

class AppLogic {
    
    private let charactersLoader: CharactersLoading
    weak var delegate: AppLogicDelegate?
    private var characters: Character = []
    
    init(charactersLoader: CharactersLoading, delegate: AppLogicDelegate?) {
        self.charactersLoader = charactersLoader
        self.delegate = delegate
    }
    
    func loadData() {
        charactersLoader.loadCharacters { result in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                switch result {
                case .success(let charactersList):
                    self.characters = charactersList
                    self.delegate?.didLoadDataFromServer()
                case .failure(let error):
                    self.delegate?.didFailToLoadData(with: error)
                }
            }
        }
    }
    
    func requestFeed() {
        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }
            self.delegate?.didReceiveFeed(Character(self.characters.shuffled()[0...4]))
        }
    }
}
