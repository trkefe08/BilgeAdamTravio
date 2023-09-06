//
//  HomeVC.swift
//  TravioApp
//
//  Created by Tarik Efe on 27.08.2023.
//

import UIKit
import TinyConstraints

class HomeVC: UIViewController {
    //MARK: - Views
    private lazy var imgHeader: UIImageView = {
        let img = UIImageView()
        img.image = #imageLiteral(resourceName: "travio")
        img.contentMode = .scaleAspectFill
        return img
    }()
    
    private lazy var rectangleView: UIView = {
        let v = UIView()
        v.backgroundColor = ColorEnum.viewColor.uiColor
        return v
    }()
    
    private lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.dataSource = self
        tv.delegate = self
        tv.register(HomeTableViewCell.self, forCellReuseIdentifier: "HomeTableViewCell" )
        return tv
    }()
    //MARK: - Variables
    var popularPlaces: PopularPlacesModel?
    var lastPlaces: PopularPlacesModel?
    var allVisits: ApiResponse?
    var viewModel = HomeViewModel()
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        viewModel.fetchPopularPlaces(limit: 5) { popular in
            self.popularPlaces = popular
        }
        viewModel.fetchLastPlaces(limit: 5) { last in
            self.lastPlaces = last
        }
    }
    
    override func viewDidLayoutSubviews() {
        rectangleView.roundCorners(corners: [.topLeft], radius: 80)
    }
    
    //MARK: - Functions
    private func setupViews() {
        self.view.backgroundColor = ColorEnum.travioBackground.uiColor
        self.view.addSubviews(imgHeader,rectangleView)
        self.rectangleView.addSubviews(tableView)
        setupLayout()
    }
    
    private func setupLayout() {
        
        imgHeader.topToSuperview(offset: 28, usingSafeArea: true)
        imgHeader.leadingToSuperview(offset: 16)
        imgHeader.height(62)
        imgHeader.width(172)
        
        rectangleView.topToBottom(of: imgHeader, offset: 35)
        rectangleView.leadingToSuperview()
        rectangleView.trailingToSuperview()
        rectangleView.bottomToSuperview()
        
        tableView.topToSuperview(offset: 87)
        tableView.leadingToSuperview(offset: 24)
        tableView.trailingToSuperview()
        tableView.bottomToSuperview()
        
    }
    
}
//MARK: - TableView Extension
extension HomeVC: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath) as? HomeTableViewCell else { return UITableViewCell() }
        switch indexPath.section {
        case 0:
            cell.configureCell(popular: popularPlaces)
        case 1:
            cell.configureCell(popular: lastPlaces)
        case 2:
            cell.configureCell(visits: allVisits)
        default:
            break
        }
        return cell
    }
    
    
}

extension HomeVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        let label = UILabel()
        let sectionTitles = ["Popular Places", "New Places", "My Added Places"]
        label.text = sectionTitles[section]
        label.font = Font.poppins(fontType: 500, size: 20).font
        label.textColor = ColorEnum.fontColor.uiColor
        headerView.addSubview(label)
        headerView.backgroundColor = ColorEnum.viewColor.uiColor
        
        return headerView
    }
}
