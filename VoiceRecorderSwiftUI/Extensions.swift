//
//  Extensions.swift
//  VoiceRecorderSwiftUI
//
//  Created by Isc. Torres on 3/6/20.
//  Copyright © 2020 isctorres. All rights reserved.
//

import SwiftUI

extension Date
{
    func toString( dateFormat format  : String ) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}
