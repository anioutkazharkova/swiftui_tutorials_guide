//
//  SearchItemCell.swift
//  NewsSwiftUI
//
//  Created by 1 on 16.02.2020.
//  Copyright © 2020 azharkova. All rights reserved.
//

import SwiftUI

struct SearchItemCell: View {
    @State var search: SearchItem
    var body: some View {
        Text(search.title ?? "")
    }
}
