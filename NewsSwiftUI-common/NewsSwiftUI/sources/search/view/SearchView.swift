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
    var output: ISearchInteractor? = nil 
    
    @ObservedObject var model: SearchModel = SearchModel()
    
    
    var body: some View {
        VStack {
            SearchBar(text: self.$text){(search) in
                self.output?.searchWithQuery(query: search)
            }
            if model.items.count > 0 {
                List {
                    ForEach(model.items){ item in
                        NewsItemRow(data: item, action: {_ in}).onTapGesture {
                            Navigator.shared.open(screen: NewsItemView.self, item)
                        }
                    }
                }
            }
            else  if model.search.count > 0 { List{
                ForEach(model.search){ item in
                    SearchItemCell(search: item).onTapGesture {
                        self.text = item.title ?? ""
                        self.output?.searchWithQuery(query: item.title ?? "")
                    }
                }
                }
            }
        }.onAppear {
            self.output?.loadSearchHistory()
        }.navigationBarTitle("Search",displayMode: .inline)
    }
    
}

extension SearchView : ISearchView {
    var viewModel: IModel? {
        return model
    }
    
    func updateModel(data: Any?) {
        self.model.update(data: data)
    }
}
