//
//  Extensions.swift
//  Expanse
//
//  Created by liwaa on 21/04/2023.
//

import Foundation
import SwiftUI



extension Color{
    
    static let background = Color("Backgorund")
    static let icon = Color("Icon")
    static let text = Color("Text")
    static let systemBackground = Color (uiColor: .systemBackground)
}


extension DateFormatter{
     
    static let allNumericUSA :DateFormatter = {
        print("initailze date formater")
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        return formatter
    }()
}


extension String{
    
    func dateParse()->Date{
        guard let parseDate = DateFormatter.allNumericUSA.date(from: self)else {return Date()}
        return parseDate
    }
    
}

extension Date: Strideable{
    func format() ->String{
        return self.formatted(.dateTime.year().month().day())
    }
}

 

