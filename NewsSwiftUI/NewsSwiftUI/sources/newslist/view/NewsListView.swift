//
//  NewsListView.swift
//  NewsSwiftUI
//
//  Created by 1 on 16.02.2020.
//  Copyright © 2020 azharkova. All rights reserved.
//

import SwiftUI
import Combine

struct NewsListView: View{
    var output: INewsListInteractor?
    @State private var isNavigationBarHidden = true
    
    @ObservedObject var model: NewsListModel =  NewsListModel.shared
    
    init() {}
    init(output: INewsListInteractor) {
        self.output = output
    }
    
    var body: some View {
        List(model.data) { item in
            NewsItemRow(data: item,action: {id in
                self.output?.updateFavorite(id: id)
            }).onTapGesture {
                Navigator.shared.open(screen: NewsItemView.self, item)
            }
        }.navigationBarTitle("News", displayMode: .inline)
            .navigationBarItems(trailing: Button(action: {
                Navigator.shared.open(screen: SearchView.self)
            }){
                Image("search").resizable().frame(width: 20, height: 20, alignment: .topTrailing)
            })
            .onAppear {
                self.output?.getNews(withRefresh: true)
        }.onDisappear {
        }
    }
    
    func updateFavorite(id: String) {
        
    }
}

struct NewsListView_Previews: PreviewProvider {
    static var previews: some View {
        NewsListView()
    }
}

extension NewsListView : INewsListView {
    func updateModel(data: Any?) {
        self.model.update(data: data)
    }
}
