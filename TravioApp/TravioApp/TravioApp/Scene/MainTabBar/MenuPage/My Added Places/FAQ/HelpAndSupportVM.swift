//
//  HelpAndSupportVM.swift
//  TravioApp
//
//  Created by Doğucan Durgun on 11.09.2023.
//


import UIKit

class HelpAndSupportVM {
    
    var isCellExpanded = Array(repeating: false, count: 30)
    
    var faq: [FAQ] = [
        FAQ(question: "Uçak biletlerini nasıl iptal edebilirim?", answer: "Uygulamamızın 'Biletlerim' bölümünden iptal işlemlerinizi gerçekleştirebilirsiniz."),
        FAQ(question: "Bagaj hakkım nedir?", answer: "Ekonomi sınıfı için 20 kg, business sınıfı için 30 kg bagaj hakkınız vardır."),
        FAQ(question: "Çocuk indirimi var mı?", answer: "2-12 yaş arası çocuklar için %50 indirim uygulanmaktadır."),
        FAQ(question: "Check-in saatleri ne zaman?", answer: "Online check-in işlemleri genellikle uçuşunuzdan 24 saat önce başlamaktadır."),
        FAQ(question: "Vize işlemleri nasıl?", answer: "Vize işlemleri ülkeye göre değişiklik göstermektedir. Detaylı bilgi için 'Vize Bilgileri' bölümüne bakabilirsiniz."),
        FAQ(question: "Vize işlemleri nasıl?", answer: "Vize işlemleri ülkeye göre değişiklik göstermektedir. Detaylı bilgi için 'Vize Bilgileri' bölümüne bakabilirsiniz."),
        FAQ(question: "Vize işlemleri nasıl?", answer: "Vize işlemleri ülkeye göre değişiklik göstermektedir. Detaylı bilgi için 'Vize Bilgileri' bölümüne bakabilirsiniz."),
        FAQ(question: "Vize işlemleri nasıl?", answer: "Vize işlemleri ülkeye göre değişiklik göstermektedir. Detaylı bilgi için 'Vize Bilgileri' bölümüne bakabilirsiniz."),
        FAQ(question: "Vize işlemleri nasıl?", answer: "Vize işlemleri ülkeye göre değişiklik göstermektedir. Detaylı bilgi için 'Vize Bilgileri' bölümüne bakabilirsiniz."),
        FAQ(question: "Vize işlemleri nasıl?", answer: "Vize işlemleri ülkeye göre değişiklik göstermektedir. Detaylı bilgi için 'Vize Bilgileri' bölümüne bakabilirsiniz."),
        FAQ(question: "Vize işlemleri nasıl?", answer: "Vize işlemleri ülkeye göre değişiklik göstermektedir. Detaylı bilgi için 'Vize Bilgileri' bölümüne bakabilirsiniz."),
        FAQ(question: "Vize işlemleri nasıl?", answer: "Vize işlemleri ülkeye göre değişiklik göstermektedir. Detaylı bilgi için 'Vize Bilgileri' bölümüne bakabilirsiniz."),
        FAQ(question: "Vize işlemleri nasıl?", answer: "Vize işlemleri ülkeye göre değişiklik göstermektedir. Detaylı bilgi için 'Vize Bilgileri' bölümüne bakabilirsiniz."),
        FAQ(question: "Vize işlemleri nasıl?", answer: "Vize işlemleri ülkeye göre değişiklik göstermektedir. Detaylı bilgi için 'Vize Bilgileri' bölümüne bakabilirsiniz."),
        FAQ(question: "Vize işlemleri nasıl?", answer: "Vize işlemleri ülkeye göre değişiklik göstermektedir. Detaylı bilgi için 'Vize Bilgileri' bölümüne bakabilirsiniz."),
        FAQ(question: "Vize işlemleri nasıl?", answer: "Vize işlemleri ülkeye göre değişiklik göstermektedir. Detaylı bilgi için 'Vize Bilgileri' bölümüne bakabilirsiniz.")
    ]
    
    func textSize(for text: String, font: UIFont, constrainedToWidth width: CGFloat) -> CGSize {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = text.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return boundingBox.size
    }
    
    func sizeForItemAt(indexPath: IndexPath, collectionViewWidth: CGFloat) -> CGSize {
        let questionText = faq[indexPath.row].question
        let answerText = faq[indexPath.row].answer
        
        let questionFont = Font.poppins(fontType: 500, size: 14).font
        let answerFont = Font.poppins(fontType: 300, size: 10).font
        
        let questionSize = textSize(for: questionText, font: questionFont, constrainedToWidth: collectionViewWidth - 105.5)
        let answerSize = textSize(for: answerText, font: answerFont, constrainedToWidth: collectionViewWidth - 64)
        
        let maxHeight = questionSize.height + answerSize.height + 44
        let minHeight = questionSize.height + 31
        let width = collectionViewWidth - 48
        
        if isCellExpanded[indexPath.row] {
            return CGSize(width: width, height: maxHeight)
        } else {
            return CGSize(width: width, height: minHeight)
        }
    }
}
