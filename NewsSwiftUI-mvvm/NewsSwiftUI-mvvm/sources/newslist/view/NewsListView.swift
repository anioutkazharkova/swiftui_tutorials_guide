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
    
    @ObservedObject var model: NewsListModel =  NewsListModel()
    
    init(){}
    
    var body: some View {
        NavigationView{
        List(model.data) { item in
            NavigationLink(destination:
            ContainerView(content: NewsItemView(item:item))) {
            NewsItemRow(data: item,action: {id in
                self.model.updateFavorite(id: id)
            })
            }
        }.navigationBarTitle("News", displayMode: .inline)
            .navigationBarItems(trailing: NavigationLink(destination: ContainerView(content:SearchView())){
                Image("search").resizable().frame(width: 20, height: 20, alignment: .topTrailing)
            })
            .onAppear {
                self.model.getNews(withRefresh: true)
        }.onDisappear {
        }
        }
    }
}

extension NewsListView:IModelView {
    var viewModel: IModel? {
        return model
    }
}
