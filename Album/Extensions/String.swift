//
//  String.swift
//  Album
//
//  Created by Shereen on 24/11/20.
//

import Foundation
extension String {
    subscript(i: Int) -> String {
        return String(self[index(startIndex, offsetBy: i)])
    }
}
