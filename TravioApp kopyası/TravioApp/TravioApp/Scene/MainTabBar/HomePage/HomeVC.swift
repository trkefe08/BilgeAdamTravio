//
//  HomeVC.swift
//  TravioApp
//
//  Created by Tarik Efe on 27.08.2023.
//
import UIKit
import TinyConstraints

final class HomeVC: UIViewController {
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
        let tv = UITableView(frame: .zero, style: .grouped)
        tv.dataSource = self
        tv.delegate = self
        tv.register(HomeTableViewCell.self, forCellReuseIdentifier: "HomeTableViewCell")
        tv.separatorColor = UIColor.clear
        tv.backgroundColor = ColorEnum.viewColor.uiColor
        tv.contentInset = UIEdgeInsets(top: 55, left: 0, bottom: 0, right: 0)
        return tv
    }()
    //MARK: - Variables
    var popularPlaces: [Place] = []
    var lastPlaces: [Place] = []
    var allVisits: [Place] = []
    var viewModel = HomeViewModel()
    var dispatchGroup = DispatchGroup()
    //MARK: - Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        configure()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        configure()
    }
    
    override func viewDidLayoutSubviews() {
        rectangleView.roundCorners(corners: [.topLeft], radius: 80)
    }
    
    //MARK: - Functions
    private func configure() {
        dispatchGroup.enter()
        viewModel.fetchPopularPlaces(limit: 5) { popular in
            guard let popular = popular.data?.places else { return }
            self.popularPlaces = popular
            self.dispatchGroup.leave()
        }
        dispatchGroup.enter()
        viewModel.fetchLastPlaces(limit: 5) { last in
            guard let last = last.data?.places else { return }
            self.lastPlaces = last
            self.dispatchGroup.leave()
        }
        dispatchGroup.enter()
        viewModel.fetchVisits(page: 1, limit: 5) { visit in
            guard let visit = visit.data?.visits else { return }
            self.allVisits = visit.map { item in
                guard let item = item.place else { return Place() }
                return item
            }
            self.dispatchGroup.leave()
        }
        dispatchGroup.notify(queue: .main) {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    private func setupViews() {
        self.navigationController?.navigationBar.isHidden = true
        self.view.backgroundColor = ColorEnum.travioBackground.uiColor
        self.rectangleView.backgroundColor = ColorEnum.viewColor.uiColor
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
        
        tableView.topToSuperview()
        tableView.leadingToSuperview()
        tableView.trailingToSuperview()
        tableView.bottomToSuperview()
    }
    
    @objc func seeAllButtonTapped(_ sender: UIButton) {
        let tappedSection = sender.tag
        
        if tappedSection == 0 {
            let vc = PopularPlacesVC()
            self.navigationController?.pushViewController(vc, animated: true)
        } else if tappedSection == 1 {
            let vc = NewPlacesVC()
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            let vc = MyVisitsVC()
            self.navigationController?.pushViewController(vc, animated: true)
        }
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
        cell.delegate = self
        switch indexPath.section {
        case 0:
            cell.configureCell(model: popularPlaces)
        case 1:
            cell.configureCell(model: lastPlaces)
        case 2:
            cell.configureCell(model: allVisits)
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
        let sectionTitles = ["Popular Places", "New Places", "My Visits"]
        label.text = sectionTitles[section]
        label.font = Font.poppins(fontType: 500, size: 20).font
        label.textColor = ColorEnum.fontColor.uiColor
        label.sizeToFit()
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        headerView.backgroundColor = ColorEnum.viewColor.uiColor
        
        let seeAllButton = UIButton(type: .system)
        seeAllButton.setTitle("See All", for: .normal)
        seeAllButton.tag = section
        seeAllButton.backgroundColor = .clear
        seeAllButton.setTitleColor(ColorEnum.seeAllButtonColor.uiColor, for: .normal)
        seeAllButton.titleLabel?.font = Font.poppins(fontType: 500, size: 14).font
        seeAllButton.addTarget(self, action: #selector(seeAllButtonTapped), for: .touchUpInside)
        
        let stackView = UIStackView(arrangedSubviews: [label, seeAllButton])
        stackView.axis = .horizontal
        
        headerView.addSubview(stackView)
        stackView.leading(to: headerView, offset: 24)
        stackView.trailing(to: headerView, offset: -16)
        stackView.centerY(to: headerView)
        stackView.bottomToSuperview(offset: -2)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 178
    }
    
}
//MARK: - Delegate Extension
extension HomeVC: HomeTableViewCellDelegate {
    func didSelectItem(with model: Place) {
        let detailVC = VisitDetailVC()
        detailVC.placeId = model.id
        self.navigationController?.pushViewController(detailVC, animated: true)
        
    }
}
