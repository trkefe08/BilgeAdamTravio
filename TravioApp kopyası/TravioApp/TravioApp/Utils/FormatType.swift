//
//  FormatType.swift
//  TravioApp
//
//  Created by Tarik Efe on 27.08.2023.
//

import Foundation

enum FormatType:String {
    case longFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    case longWithoutZone = "yyyy-MM-dd'T'HH:mm:ssZ" //"yyyy-MM-dd'T'HH:mm:ss"
    case withoutYear = "dd MMMM"
    case localeStandard = "d MMMM yyyy"  //"dd.MM.yyyy"
    case standard = "yyyy-MM-dd"
    case dateAndTime = "dd.MM.yyyy'T'HH:mm"
    case time = "HH:mm"
}
