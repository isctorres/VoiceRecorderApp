//
//  Helper.swift
//  VoiceRecorderSwiftUI
//
//  Created by Isc. Torres on 3/6/20.
//  Copyright © 2020 isctorres. All rights reserved.
//

import SwiftUI

/*struct Helper: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct Helper_Previews: PreviewProvider {
    static var previews: some View {
        Helper()
    }
}*/
func getCreationDate(for file: URL) -> Date {
    if let attributes = try? FileManager.default.attributesOfItem(atPath: file.path) as [FileAttributeKey: Any],
        let creationDate = attributes[FileAttributeKey.creationDate] as? Date {
        return creationDate
    } else {
        return Date()
    }
}
