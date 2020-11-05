//
//  DoubleExtension.swift
//  glamera
//
//  Created by Smart Zone on 12/23/19.
//  Copyright © 2019 ahmed ezz. All rights reserved.
//

import Foundation

extension Double {

    // returns the date formatted.
     var dateFormatted : String? {
         let date = Date(timeIntervalSince1970: self)
         let dateFormatter = DateFormatter()
         dateFormatter.timeStyle = DateFormatter.Style.none //Set time style
         dateFormatter.dateStyle = DateFormatter.Style.short //Set date style
         return dateFormatter.string(from: date)
     }
     
     // returns the date formatted according to the format string provided.
     func dateFormatted(withFormat format : String) -> String{
         let date = Date(timeIntervalSince1970: self)
         let dateFormatter = DateFormatter()
         dateFormatter.dateFormat = format
         return dateFormatter.string(from: date)
     }
}
