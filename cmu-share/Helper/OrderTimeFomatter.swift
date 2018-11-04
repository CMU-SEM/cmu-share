//
//  OrderTimeFomatter.swift
//  cmu-share
//
//  Created by Pattarasai Markpeng on 11/4/18.
//  Copyright © 2018 Pattarasai Markpeng. All rights reserved.
//

import Foundation


class OrderTimeFomatter {
    static func format(hr: Int, min: Int) -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "HH:mm"
        
        let date = Calendar.current.date(bySettingHour: hr, minute: min, second: 0, of: Date())
    
        let resultFormatter = DateFormatter()
        resultFormatter.locale = Locale(identifier: "en_US_POSIX")
        resultFormatter.dateFormat = "hh:mm a"
        resultFormatter.amSymbol = "AM"
        resultFormatter.pmSymbol = "PM"
        
        return resultFormatter.string(from: date!)
    }
}
