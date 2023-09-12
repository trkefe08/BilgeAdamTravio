//
//  HelpAndSupportVC.swift
//  TravioApp
//
//  Created by Doğucan Durgun on 8.09.2023.
//

import UIKit
import SnapKit

class HelpAndSupportVC: UIViewController {
    
    let sikcaSorulanSorular: [(soru: String, cevap: String)] = [
        ("Swift ve Objective-C arasındaki ana fark nedir?", "Swift daha modern ve güvenli, Objective-C daha eski ve dinamik."),
        ("Optional nedir?", "Değişkenin bir değeri olabileceği veya nil olabileceği anlamına gelir."),
        ("guard ifadesi ne için kullanılır?", "Koşulları kontrol etmek ve erken çıkmak için."),
        ("map, filter, reduce fonksiyonları ne işe yarar?", "Dizileri veya koleksiyonları dönüştürmek, süzmek ve bir araya getirmek için."),
        ("Programatik bir şekilde buton oluşturmak için ne yapmalıyım?", "UIButton örneği oluştur ve addSubview ile ekleyin."),
        ("Storyboard yerine programatik UI kullanmanın avantajları nelerdir?", "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed eu enim sed nisi condimentum tristique nec ac sapien. Etiam ultrices elit egestas sodales sagittis. Nulla facilisi. Nam vitae rhoncus urna. Duis ut pretium ligula. Nunc rhoncus nec augue nec malesuada. Mauris vulputate ante sed rutrum euismod. Duis vitae ligula nec elit condimentum ultricies vitae et ipsum. Maecenas dignissim tortor sit amet massa varius suscipit."),
        ("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed eu enim sed nisi condimentum tristique nec ac sapien. Etiam ultrices elit egestas sodales sagittis. Nulla facilisi. Nam vitae rhoncus urna. Duis ut pretium ligula. Nunc rhoncus nec augue nec malesuada. Mauris vulputate ante sed rutrum euismod. Duis vitae ligula nec elit condimentum ultricies vitae et ipsum. Maecenas dignissim tortor sit amet massa varius suscipit.", "Otomatik Referans Sayımı, bellek yönetimi için."),
        ("Enum kullanmanın faydaları nelerdir?", "Daha okunabilir ve güvenli kod."),
        ("closures ne işe yarar?", "Fonksiyonları değişken gibi kullanmayı sağlar."),
        ("Codable protokolü ne için kullanılır?", "JSON serileştirme ve deserializasyon için.")
    ]
    
    var isCellExpanded = Array(repeating: false, count: 10)

    private lazy var retangle:CustomBackgroundRetangle = {
        let view = CustomBackgroundRetangle()
        
        return view
    }()
    
    private lazy var backButton:UIButton = {
       let button = UIButton()
        button.setImage(UIImage(named: "Vector"), for: .normal)
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)

        return button
    }()

    private lazy var header:UILabel = {
       let label = UILabel()
        label.text = "Help&Support"
        label.font = Font.poppins(fontType: 600, size: 32).font
        label.textColor = .white

        return label
    }()
    
    private lazy var label:UILabel = {
        let lbl = UILabel()
        lbl.text = "FAQ"
        lbl.font = Font.poppins(fontType: 600, size: 24).font
        lbl.textColor = ColorEnum.travioBackground.uiColor
        return lbl
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 18
        layout.sectionInset = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        cv.register(HelpAndSupportCVC.self, forCellWithReuseIdentifier: "cell")
        cv.backgroundColor = ColorEnum.viewColor.uiColor
        
        return cv
    }()
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    func textSize(for text: String, font: UIFont, constrainedToWidth width: CGFloat) -> CGSize {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = text.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return boundingBox.size
    }
    
    func setupView(){
        self.view.backgroundColor = ColorEnum.travioBackground.uiColor
        
        view.addSubviews(retangle,backButton,header)
        retangle.addSubviews(label,collectionView)
        setupLayouts()
    }
    
    func setupLayouts() {
        
        backButton.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(36)
            make.leading.equalToSuperview().offset(20)
            make.height.equalTo(21.5)
            make.width.equalTo(24)
        }

        header.snp.makeConstraints { make in
            make.leading.equalTo(backButton.snp.trailing).offset(24)
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(23)
        }

        retangle.snp.makeConstraints { make in
            make.top.equalTo(header.snp.bottom).offset(54)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        label.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(44)
            make.leading.equalToSuperview().offset(24)
        }
        
        collectionView.snp.makeConstraints { make in
            make.bottom.leading.trailing.equalToSuperview()
            make.top.equalTo(label.snp.bottom).offset(20)
            
        }
        
        
    }
    
}

extension HelpAndSupportVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? HelpAndSupportCVC else { return UICollectionViewCell()}
        
        cell.question.text = sikcaSorulanSorular[indexPath.row].soru
        cell.answer.text = sikcaSorulanSorular[indexPath.row].cevap
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
           let questionText = sikcaSorulanSorular[indexPath.row].soru
           let answerText = sikcaSorulanSorular[indexPath.row].cevap
           
        let questionFont = Font.poppins(fontType: 500, size: 14).font  // Soru için kullanılan font boyutu
        let answerFont = Font.poppins(fontType: 300, size: 10).font // Cevap için kullanılan font boyutu

        let questionSize = textSize(for: questionText, font: questionFont, constrainedToWidth: collectionView.frame.width-105.5)
        let answerSize = textSize(for: answerText, font: answerFont, constrainedToWidth: collectionView.frame.width-64)
           
           let totalHeight = questionSize.height + answerSize.height + 28  // +20, soru ve cevap arasında biraz boşluk bırakmak için
        
        if isCellExpanded[indexPath.row] {
            return CGSize(width: collectionView.frame.width-48, height: totalHeight) // Genişletilmiş boyut
        } else {
            return CGSize(width: collectionView.frame.width-48, height: questionSize.height + 31) // Normal boyut
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        isCellExpanded[indexPath.row] = !isCellExpanded[indexPath.row] // Durumu tersine çevir
        collectionView.reloadItems(at: [indexPath]) // Hücreyi yeniden yükle
    }

}
