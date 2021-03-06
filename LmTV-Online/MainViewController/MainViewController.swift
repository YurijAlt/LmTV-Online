//
//  ViewController.swift
//  LmTV-Online
//
//  Created by Юрий Чекалюк on 07.04.2022.
//

import UIKit
import AVKit

//MARK: MainViewProtocol
protocol MainViewProtocol: AnyObject {
    func reloadData()
}
class MainViewController: UIViewController {
    
    //MARK: Views
    private lazy var searchView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.1922112107, green: 0.1919049621, blue: 0.2093025744, alpha: 1)
        return view
    }()
    private lazy var buttonView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.1922112107, green: 0.1919049621, blue: 0.2093025744, alpha: 1)
        return view
    }()
    
    private lazy var allChannelsButton: UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .heavy)
        button.setTitle("Все", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.addTarget(self, action: #selector(allChannelsButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var favoriteChannelsButton: UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .heavy)
        button.setTitle("Избранное", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.6000263691, green: 0.5998786092, blue: 0.6086004972, alpha: 1), for: .normal)
        button.addTarget(self, action: #selector(favoriteChannelsButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var pixelLineView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.2883962095, green: 0.2983643711, blue: 0.3153583407, alpha: 1)
        return view
    }()
    
    
    private lazy var mainSegmentedControl: UISegmentedControl = {
        let items = ["", ""]
        let segmentedControl = UISegmentedControl(items: items)
        segmentedControl.backgroundColor = #colorLiteral(red: 0.1922112107, green: 0.1919049621, blue: 0.2093025744, alpha: 1)
        segmentedControl.selectedSegmentTintColor = #colorLiteral(red: 0, green: 0.475726068, blue: 1, alpha: 1)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.setWidth(allChannelsButton.frame.width + 24, forSegmentAt: 0)
        segmentedControl.setWidth(favoriteChannelsButton.frame.width + 24, forSegmentAt: 1)
        return segmentedControl
    }()
    
    
    private lazy var mainTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = #colorLiteral(red: 0.1363289952, green: 0.1411529481, blue: 0.1541091204, alpha: 1)
        tableView.register(MainViewTableViewCell.self, forCellReuseIdentifier: MainViewTableViewCell.cellIdentifier)
        tableView.keyboardDismissMode = .interactive
        return tableView
        
    }()
    
    private lazy var channelSearchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Напишите название телеканала"
        searchBar.backgroundColor = #colorLiteral(red: 0.1922112107, green: 0.1919049621, blue: 0.2093025744, alpha: 1)
        searchBar.barTintColor = #colorLiteral(red: 0.1922112107, green: 0.1919049621, blue: 0.2093025744, alpha: 1)
        searchBar.searchBarStyle = .minimal
        let imageView = UIImageView(image: UIImage(systemName: "magnifyingglass"))
        imageView.tintColor = #colorLiteral(red: 0.5010578632, green: 0.5058031082, blue: 0.523140192, alpha: 1)
        searchBar.searchTextField.textColor = .white
        searchBar.searchTextField.leftView = imageView
        searchBar.isTranslucent = false
        return searchBar
    }()
    
    //MARK: - Private Properties
    private var isFirstSegmentSelected = true
    private let urlString = "http://iptvm3u.ru/onelist.m3u"
    private var presenter: MainViewPresenterProtocol!
    
    //MARK: - Life Circle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.1363289952, green: 0.1411529481, blue: 0.1541091204, alpha: 1)
        
        view.addSubview(searchView)
        searchView.addSubview(channelSearchBar)
        
        view.addSubview(buttonView)
        buttonView.addSubview(allChannelsButton)
        buttonView.addSubview(favoriteChannelsButton)
        buttonView.addSubview(mainSegmentedControl)
        
        view.addSubview(pixelLineView)
        view.addSubview(mainTableView)
        
        setupConstraints()
        
        mainTableView.dataSource = self
        mainTableView.delegate = self
        
        let networkManager = NetworkManager()
        presenter = MainViewPresenter(view: self, networkManager: networkManager)
        channelSearchBar.delegate = self
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        mainSegmentedControl.setWidth(58, forSegmentAt: 0)
        mainSegmentedControl.setWidth(116, forSegmentAt: 1)
    }
    
    //MARK: - Private Methods
    private func createPlayer(videoStringURL: String) {
        guard let url = URL(string: videoStringURL) else { return }
        let player = AVPlayer(url: url)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        present(playerViewController, animated: true) {
            player.play()
        }
    }
    
    @objc private func allChannelsButtonTapped() {
        allChannelsButton.setTitleColor(UIColor.white, for: .normal)
        favoriteChannelsButton.setTitleColor(#colorLiteral(red: 0.6000263691, green: 0.5998786092, blue: 0.6086004972, alpha: 1), for: .normal)
        mainSegmentedControl.selectedSegmentIndex = 0
        isFirstSegmentSelected = true
        mainTableView.reloadData()
    }
    
    @objc private func favoriteChannelsButtonTapped() {
        allChannelsButton.setTitleColor(#colorLiteral(red: 0.6000263691, green: 0.5998786092, blue: 0.6086004972, alpha: 1), for: .normal)
        favoriteChannelsButton.setTitleColor(UIColor.white, for: .normal)
        mainSegmentedControl.selectedSegmentIndex = 1
        isFirstSegmentSelected = false
        mainTableView.reloadData()
    }

    private func setupConstraints() {
        //SearchView
        searchView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchView.topAnchor.constraint(equalTo: view.topAnchor),
            searchView.leftAnchor.constraint(equalTo: view.leftAnchor),
            searchView.rightAnchor.constraint(equalTo: view.rightAnchor),
            searchView.heightAnchor.constraint(equalToConstant: 92)
        ])
        //ChannelSearchBar
        channelSearchBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            channelSearchBar.leftAnchor.constraint(equalTo: searchView.leftAnchor, constant: 24),
            channelSearchBar.rightAnchor.constraint(equalTo: searchView.rightAnchor, constant: -24),
            channelSearchBar.bottomAnchor.constraint(equalTo: searchView.bottomAnchor, constant: -6)
        ])
        //ButtonView
        buttonView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            buttonView.topAnchor.constraint(equalTo: searchView.bottomAnchor),
            buttonView.leftAnchor.constraint(equalTo: view.leftAnchor),
            buttonView.rightAnchor.constraint(equalTo: view.rightAnchor),
            buttonView.heightAnchor.constraint(equalToConstant: 56)
        ])
        ////
        //AllChannelsButton
        allChannelsButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            allChannelsButton.topAnchor.constraint(equalTo: buttonView.topAnchor),
            allChannelsButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 32),
            allChannelsButton.widthAnchor.constraint(equalToConstant: 56)
        ])
        //FaviriteChannelsButton
        favoriteChannelsButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            favoriteChannelsButton.topAnchor.constraint(equalTo: buttonView.topAnchor),
            favoriteChannelsButton.leftAnchor.constraint(equalTo: allChannelsButton.rightAnchor),
            favoriteChannelsButton.widthAnchor.constraint(equalToConstant: 116)
        ])
        
        //MainSegmentedControl
        mainSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainSegmentedControl.bottomAnchor.constraint(equalTo: buttonView.bottomAnchor, constant: -8),
            mainSegmentedControl.heightAnchor.constraint(equalToConstant: 2),
            mainSegmentedControl.leftAnchor.constraint(equalTo: allChannelsButton.leftAnchor),
            mainSegmentedControl.rightAnchor.constraint(equalTo: favoriteChannelsButton.rightAnchor),
        ])
        //PixelView
        pixelLineView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pixelLineView.topAnchor.constraint(equalTo: buttonView.bottomAnchor),
            pixelLineView.leftAnchor.constraint(equalTo: view.leftAnchor),
            pixelLineView.rightAnchor.constraint(equalTo: view.rightAnchor),
            pixelLineView.heightAnchor.constraint(equalToConstant: 1)
        ])
        //MainTableView
        mainTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainTableView.topAnchor.constraint(equalTo: pixelLineView.bottomAnchor, constant: 20),
            mainTableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 4),
            mainTableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -4),
            mainTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

//MARK: - UITableViewDataSource
extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        switch isFirstSegmentSelected {
        case true:
            return presenter.channels?.count ?? 0
        case false:
            return StorageManager.shared.realm.objects(FavoriteChannel.self).count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var isFavoriteStatus: Bool = false
        let networkObject = presenter.channels?[indexPath.row].name
        let dataObject = StorageManager.shared.realm.objects(FavoriteChannel.self).filter("name = %@", networkObject ?? "")
        if dataObject.isEmpty {
            isFavoriteStatus = false
        } else {
            isFavoriteStatus = true
        }

        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainViewTableViewCell.cellIdentifier, for: indexPath) as? MainViewTableViewCell else { return UITableViewCell() }
        
        cell.backgroundColor = #colorLiteral(red: 0.2039211392, green: 0.2039219141, blue: 0.2210820913, alpha: 1)
        cell.layer.borderColor = #colorLiteral(red: 0.1363289952, green: 0.1411529481, blue: 0.1541091204, alpha: 1)
        cell.layer.borderWidth = 4
        cell.layer.cornerRadius = 10
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor(cgColor: UIColor.lightGray.cgColor)
        backgroundView.layer.cornerRadius = 10
        backgroundView.layer.masksToBounds = true
        cell.selectedBackgroundView = backgroundView
        
        
        switch isFirstSegmentSelected {
        case true:
            cell.configure(
                with: presenter.channels?[indexPath.row].name ?? "",
                channelTitle: presenter.channels?[indexPath.row].current?.title ?? "",
                image: presenter.channels?[indexPath.row].image ?? "",
                isStarButtonActive: isFavoriteStatus
            )
        case false:
            let favoriteChannels = StorageManager.shared.realm.objects(FavoriteChannel.self)
            cell.configure(
                with: favoriteChannels[indexPath.row].name,
                channelTitle: favoriteChannels[indexPath.row].title,
                image: favoriteChannels[indexPath.row].image,
                isStarButtonActive: true
            )
        }
        return cell
    }
}

//MARK: - UITableVeiwDelegate
extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        createPlayer(videoStringURL: urlString)
    }
}

//MARK: - MainViewProtocol
extension MainViewController: MainViewProtocol {
    func reloadData() {
        mainTableView.reloadData()
    }
}

//MARK: - Keyboard Settings
extension MainViewController: UITextViewDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
}


//MARK: - UISearchBarDelegate
extension MainViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
   
    }
}
