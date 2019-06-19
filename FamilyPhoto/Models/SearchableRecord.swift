//
//  SearchableRecord.swift
//  FamilyPhoto
//
//  Created by Colin Smith on 6/18/19.
//  Copyright © 2019 Colin Smith. All rights reserved.
//

import Foundation

protocol SearchableRecord {
    func matches(searchTerm: String) -> Bool
}
