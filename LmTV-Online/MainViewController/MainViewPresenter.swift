//
//  MainViewPresenter.swift
//  LmTV-Online
//
//  Created by Юрий Чекалюк on 07.04.2022.
//

import Foundation

//MARK: MainViewPresenterProtocol
protocol MainViewPresenterProtocol {
    init(view: MainViewProtocol, networkManager: NetworkManagerProtocol)
    func fetchChannels()
    var channels: Channel? { get set }
}

class MainViewPresenter: MainViewPresenterProtocol {
    unowned let view: MainViewProtocol
    let networkManager: NetworkManagerProtocol!
    var channels: Channel?
    var imageData: Data?
    
    required init(view: MainViewProtocol, networkManager: NetworkManagerProtocol) {
        self.view = view
        self.networkManager = networkManager
    }
    
    func fetchChannels() {
        networkManager.fetchListOfChannels { [weak self] channels in
            guard let self = self else { return }
            self.channels = channels
            self.view.reloadData()
        }
    }
}
