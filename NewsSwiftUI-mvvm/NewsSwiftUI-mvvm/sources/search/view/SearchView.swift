//
//  SearchView.swift
//  NewsSwiftUI
//
//  Created by 1 on 16.02.2020.
//  Copyright © 2020 azharkova. All rights reserved.
//

import SwiftUI

struct SearchView: View {
    @State private var text: String = ""
    @ObservedObject var model: SearchModel = SearchModel()
    
    
    var body: some View {
        VStack {
            SearchBar(text: self.$text){(search) in
                DispatchQueue.main.async {
                    self.model.searchWithQuery(query: search)
                }
            }
            if model.items.count > 0 {
                List {
                    ForEach(model.items){ item in
                        NewsItemRow(data: item, action: {_ in})
                    }
                }
            }
            else  if model.search.count > 0 { List{
                ForEach(model.search){ item in
                    SearchItemCell(search: item).onTapGesture {
                        self.text = item.title ?? ""
                        self.model.searchWithQuery(query: item.title ?? "")
                    }
                }
                }
            }
            Spacer()
        }.onAppear {
            self.model.loadSearchHistory()
        }.navigationBarTitle("Search",displayMode: .inline)
    }
}

extension SearchView : IModelView {
    var viewModel: IModel? {
        get {
            return model
        }
    }
}
