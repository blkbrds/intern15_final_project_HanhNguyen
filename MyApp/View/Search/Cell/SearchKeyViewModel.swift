//
//  SearchKeyCellViewModel.swift
//  MyApp
//
//  Created by ANH NGUYỄN on 2/23/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation

protocol SearchCellViewModel { }

final class SearchKeyCellViewModel: SearchCellViewModel {
    var key: String
    
    init(key: String) {
        self.key = key
    }
}
