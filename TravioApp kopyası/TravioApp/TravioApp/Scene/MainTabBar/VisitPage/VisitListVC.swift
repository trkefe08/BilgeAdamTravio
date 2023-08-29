//
//  VisitListVC.swift
//  TravioApp
//
//  Created by Tarik Efe on 27.08.2023.
//
import UIKit
import TinyConstraints
import Kingfisher

class VisitListVC: UIViewController {
    //MARK: - IBOutlets
    private lazy var headerLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "My Visits"
        lbl.textColor = .white
        lbl.font = UIFont(name: "Poppins-Bold", size: 36)
        return lbl
    }()
    
    private lazy var rectangleView: UIView = {
        let v = UIView()
        let selectedColor = ColorEnum.viewColor
        if let colorValue = selectedColor.uiColor {
            v.backgroundColor = colorValue
        }
        return v
    }()
    
    private lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.dataSource = self
        tv.delegate = self
        tv.register(VisitListTableViewCell.self, forCellReuseIdentifier: "VisitTableViewCell" )
        let selectedColor = ColorEnum.viewColor
        if let colorValue = selectedColor.uiColor {
            tv.backgroundColor = colorValue
        }
        return tv
    }()
    
    //MARK: - Variables
    var viewModel = VisitListViewModel()
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        viewModel.delegate = self
        viewModel.fetchVisitList()
    }
    
    override func viewDidLayoutSubviews() {
        rectangleView.roundCorners(corners: .topLeft, radius: 80)
    }
    
    //MARK: - Funcstions
    func setupViews() {
        self.navigationController?.navigationBar.isHidden = true
        let selectedColor = ColorEnum.travioBackground
        if let colorValue = selectedColor.uiColor {
            self.view.backgroundColor = colorValue
        }
        self.view.addSubviews(headerLabel, rectangleView)
        self.rectangleView.addSubviews(tableView)
        setupLayout()
    }
    
    func setupLayout() {
        headerLabel.topToSuperview(offset: 24, usingSafeArea: true)
        headerLabel.leadingToSuperview(offset: 24)
        
        rectangleView.topToBottom(of: headerLabel, offset: 52)
        rectangleView.edgesToSuperview(excluding: .top)
        
        tableView.top(to: rectangleView, offset: 45)
        tableView.leading(to: rectangleView, offset: 24)
        tableView.trailing(to: rectangleView, offset: -24)
        tableView.bottomToSuperview()
    }
}

extension VisitListVC: VisitListViewModelDelegate {
    func visitLoaded() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension VisitListVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 219
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = VisitDetailVC()
        guard let newVisitId = viewModel.getVisit(at: indexPath.row)?.id else { return }
        detailVC.visitId = newVisitId
        self.navigationController?.pushViewController(detailVC, animated: true)
        
    }
}

extension VisitListVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRow
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "VisitTableViewCell", for: indexPath) as? VisitListTableViewCell else { return UITableViewCell()}
        cell.indexPath = indexPath
        let model = viewModel.getVisit(at: indexPath.row) ?? PlaceVisit()
        let imageURL = viewModel.getVisit(at: indexPath.row)?.coverImageURL
        cell.configureCell(model: model)
        
        cell.loadImage(with: imageURL) { [weak self] loadedIndexPath in
            guard let self = self, let visibleIndexPaths = self.tableView.indexPathsForVisibleRows,
                  visibleIndexPaths.contains(loadedIndexPath) else {
                return
            }
            
            self.viewModel.markImageLoaded(at: loadedIndexPath.row)
            
            DispatchQueue.main.async {
                tableView.reloadRows(at: [loadedIndexPath], with: .none)
            }
            
            
        }
        
        return cell
    }
}

