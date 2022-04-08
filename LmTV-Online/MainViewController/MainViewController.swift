//
//  ViewController.swift
//  LmTV-Online
//
//  Created by Юрий Чекалюк on 07.04.2022.
//

import UIKit

//MARK: MainViewProtocol
protocol MainViewProtocol: AnyObject {
    func reloadData()
}
class MainViewController: UIViewController {
    
    //MARK: Views
    private lazy var searchView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
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
        //button.backgroundColor = .blue
        
        //button.setTitleColor(UIColor.red, for: UIControl.State.normal)
        
        button.addTarget(self, action: #selector(allChannelsButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var favoriteChannelsButton: UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .heavy)
        button.setTitle("Избранное", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.6000263691, green: 0.5998786092, blue: 0.6086004972, alpha: 1), for: .normal)
        //button.backgroundColor = .orange
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
        //tableView.tintColor = .red
        tableView.register(MainViewTableViewCell.self, forCellReuseIdentifier: MainViewTableViewCell.cellIdentifier)
        
        //tableView.rowHeight = 200
        return tableView
        
    }()
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Напишите название телеканала"
        searchBar.backgroundColor = #colorLiteral(red: 0.1922112107, green: 0.1919049621, blue: 0.2093025744, alpha: 1)
        searchBar.barTintColor = #colorLiteral(red: 0.1922112107, green: 0.1919049621, blue: 0.2093025744, alpha: 1)
        searchBar.searchBarStyle = UISearchBar.Style.default
        searchBar.isTranslucent = false
        return searchBar
    }()
    
    //MARK: - Private Properties
    private var isFirstSegmentSelected = true
    
    private var presenter: MainViewPresenterProtocol!

    //MARK: - Life Circle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.1363289952, green: 0.1411529481, blue: 0.1541091204, alpha: 1)
        
        view.addSubview(searchView)
        searchView.addSubview(searchBar)
        
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
        presenter.fetchChannels()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        mainSegmentedControl.setWidth(58, forSegmentAt: 0)
        mainSegmentedControl.setWidth(116, forSegmentAt: 1)
    }

    //MARK: - Private Methods
    @objc private func allChannelsButtonTapped() {
        allChannelsButton.setTitleColor(UIColor.white, for: .normal)
        favoriteChannelsButton.setTitleColor(#colorLiteral(red: 0.6000263691, green: 0.5998786092, blue: 0.6086004972, alpha: 1), for: .normal)
        mainSegmentedControl.selectedSegmentIndex = 0
        mainTableView.reloadData()
    }
    
    @objc private func favoriteChannelsButtonTapped() {
        allChannelsButton.setTitleColor(#colorLiteral(red: 0.6000263691, green: 0.5998786092, blue: 0.6086004972, alpha: 1), for: .normal)
        favoriteChannelsButton.setTitleColor(UIColor.white, for: .normal)
        mainSegmentedControl.selectedSegmentIndex = 1
        mainTableView.reloadData()
    }
    
    private func setupConstraints() {
        //SearchView
        searchView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            searchView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            searchView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
            searchView.heightAnchor.constraint(equalToConstant: 144)
        ])
        //SearchBar
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: searchView.topAnchor, constant: 0),
            searchBar.leftAnchor.constraint(equalTo: searchView.leftAnchor, constant: 0),
            searchBar.rightAnchor.constraint(equalTo: searchView.rightAnchor, constant: 0),
            searchBar.bottomAnchor.constraint(equalTo: searchView.bottomAnchor, constant: 0)
        ])
        //ButtonView
        buttonView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            buttonView.topAnchor.constraint(equalTo: searchView.bottomAnchor, constant: -21),
            buttonView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            buttonView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
            buttonView.heightAnchor.constraint(equalToConstant: 56)
        ])
        ////
        //AllChannelsButton
        allChannelsButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            allChannelsButton.topAnchor.constraint(equalTo: buttonView.topAnchor, constant: 0),
            allChannelsButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 32),
            allChannelsButton.widthAnchor.constraint(equalToConstant: 58)
        ])
        //FaviriteChannelsButton
        favoriteChannelsButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            favoriteChannelsButton.topAnchor.constraint(equalTo: buttonView.topAnchor, constant: 0),
            favoriteChannelsButton.leftAnchor.constraint(equalTo: allChannelsButton.rightAnchor, constant: 0),
            favoriteChannelsButton.widthAnchor.constraint(equalToConstant: 116)
        ])
        
        //MainSegmentedControl
        mainSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainSegmentedControl.bottomAnchor.constraint(equalTo: buttonView.bottomAnchor, constant: -6),
            mainSegmentedControl.heightAnchor.constraint(equalToConstant: 2),
            mainSegmentedControl.leftAnchor.constraint(equalTo: allChannelsButton.leftAnchor, constant: 0),
            mainSegmentedControl.rightAnchor.constraint(equalTo: favoriteChannelsButton.rightAnchor, constant: 0),
        ])
        //PixelView
        pixelLineView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pixelLineView.topAnchor.constraint(equalTo: buttonView.bottomAnchor, constant: 0),
            pixelLineView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            pixelLineView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
            pixelLineView.heightAnchor.constraint(equalToConstant: 1)
        ])
        //MainTableView
        mainTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainTableView.topAnchor.constraint(equalTo: pixelLineView.bottomAnchor, constant: 20),
            mainTableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 4),
            mainTableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -4),
            mainTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    }
}

//MARK: - UITableViewDataSource
extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.channels?.channels?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
        cell.configure(
            with: presenter.channels?.channels?[indexPath.row].name ?? "",
            channelTitle: presenter.channels?.channels?[indexPath.row].current?.title ?? ""
        )
        return cell
    }
}

//MARK: - UITableVeiwDelegate
extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

//MARK: - MainViewProtocol
extension MainViewController: MainViewProtocol {
    func reloadData() {
        mainTableView.reloadData()
    }
}
