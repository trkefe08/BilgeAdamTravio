//
//  HelpAndSupportVM.swift
//  TravioApp
//
//  Created by Doğucan Durgun on 12.09.2023.
//

import Foundation
import UIKit

class HelpAndSupportVM {
    
    var isCellExpanded = Array(repeating: false, count: 30)
    
    let faqs: [FAQ] = [
        FAQ(question: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi nulla odio, condimentum eget bibendum eget, maximus in lacus. In hac habitasse platea dictumst. Donec lacus mauris, tempus iaculis lacus at, sollicitudin congue purus. Sed eu ante nec mauris luctus vehicula. Maecenas tortor ex, facilisis non ornare sed, fermentum vitae quam. Duis tristique, odio et dapibus commodo, velit arcu suscipit enim, non imperdiet odio odio at arcu. Donec egestas velit blandit ante bibendum, id aliquet nibh venenatis. Nunc eu feugiat mauris, sit amet suscipit urna. Etiam maximus justo nec orci interdum, sit amet tincidunt tellus ultricies.", answer: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi nulla odio, condimentum eget bibendum eget, maximus in lacus. In hac habitasse platea dictumst. Donec lacus mauris, tempus iaculis lacus at, sollicitudin congue purus. Sed eu ante nec mauris luctus vehicula. Maecenas tortor ex, facilisis non ornare sed, fermentum vitae quam. Duis tristique, odio et dapibus commodo, velit arcu suscipit enim, non imperdiet odio odio at arcu. Donec egestas velit blandit ante bibendum, id aliquet nibh venenatis. Nunc eu feugiat mauris, sit amet suscipit urna. Etiam maximus justo nec orci interdum, sit amet tincidunt."),
        FAQ(question: "Uygulamanız nasıl çalışır?", answer: "Uygulamamızı indirdikten sonra bir hesap oluşturun ve seyahat planlarınızı hemen yapmaya başlayın."),
        FAQ(question: "Üyelik ücretli mi?", answer: "Temel özellikler ücretsizdir, fakat premium özellikler için üyelik planımızı satın alabilirsiniz."),
        FAQ(question: "Biletlerimi nasıl iptal edebilirim?", answer: "Hesabınızdaki 'Biletlerim' bölümünden iptal işlemini gerçekleştirebilirsiniz."),
        FAQ(question: "Ödeme seçenekleri neler?", answer: "Kredi kartı, banka havalesi ve PayPal gibi çeşitli ödeme seçeneklerimiz mevcuttur."),
        FAQ(question: "Çocuklar için indirim var mı?", answer: "Evet, 12 yaş altı çocuklar için %50 indirim sağlamaktayız."),
        FAQ(question: "Bagaj hakkım nedir?", answer: "Bagaj hakkı seyahatin türüne göre değişkenlik göstermektedir."),
        FAQ(question: "Check-in nasıl yapılır?", answer: "Mobil uygulamamız üzerinden veya havaalanındaki kiosklardan check-in yapabilirsiniz."),
        FAQ(question: "Promosyon kodu nasıl kullanılır?", answer: "Ödeme ekranında 'Promosyon Kodu' bölümüne kodunuzu girebilirsiniz."),
        FAQ(question: "Evcil hayvan kabul ediliyor mu?", answer: "Evet, ancak belirli kurallar ve ücretler vardır."),
        FAQ(question: "WiFi var mı?", answer: "Evet, tüm uçuşlarımızda ücretli WiFi hizmetimiz vardır."),
        FAQ(question: "Grup indirimi var mı?", answer: "Evet, 10 kişi ve üzeri gruplar için özel indirimlerimiz bulunmaktadır."),
        FAQ(question: "Seyahat sigortası yapılıyor mu?", answer: "Evet, ek bir ücret karşılığı seyahat sigortası yapabilirsiniz."),
        FAQ(question: "Hangi havaalanlarına servis var?", answer: "Ülke genelinde 50'den fazla havaalanına servisimiz bulunmaktadır."),
        FAQ(question: "Kayıp eşya ne yapmalıyım?", answer: "Müşteri hizmetleri ile iletişime geçebilir veya uygulamada 'Kayıp Eşya' formunu doldurabilirsiniz."),
        FAQ(question: "Uçuşlar ne sıklıkla iptal oluyor?", answer: "Uçuşlarımızın %99'u zamanında gerçekleşmektedir."),
        FAQ(question: "Erken check-in yapabilir miyim?", answer: "Evet, erken check-in yapabilirsiniz fakat bu hizmet ek ücrete tabidir."),
        FAQ(question: "Gecikme durumunda ne yapmalıyım?", answer: "Uygulamamız üzerinden gecikme bilgilerini anlık olarak takip edebilirsiniz."),
        FAQ(question: "Çocuklar için oyun alanı var mı?", answer: "Evet, bazı büyük havaalanlarında çocuklar için oyun alanlarımız bulunmaktadır."),
        FAQ(question: "Destek hattı 7/24 açık mı?", answer: "Evet, müşteri hizmetlerimiz 7/24 hizmet vermektedir.")
    ]

    func textSize(for text: String, font: UIFont, constrainedToWidth width: CGFloat) -> CGSize {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = text.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return boundingBox.size
    }
    
    func sizeForItemAt(indexPath: IndexPath, collectionViewWidth: CGFloat) -> CGSize {
          
          let questionText = faqs[indexPath.row].question
          let answerText = faqs[indexPath.row].answer
          
          let questionFont = Font.poppins(fontType: 500, size: 14).font
          let answerFont = Font.poppins(fontType: 300, size: 10).font

          let questionSize = textSize(for: questionText, font: questionFont, constrainedToWidth: collectionViewWidth - 105.5)
          let answerSize = textSize(for: answerText, font: answerFont, constrainedToWidth: collectionViewWidth - 64)

          let totalHeight = questionSize.height + answerSize.height + 40

          if isCellExpanded[indexPath.row] {
              return CGSize(width: collectionViewWidth - 48, height: totalHeight)
          } else {
              return CGSize(width: collectionViewWidth - 48, height: questionSize.height + 31)
          }
      }
}
