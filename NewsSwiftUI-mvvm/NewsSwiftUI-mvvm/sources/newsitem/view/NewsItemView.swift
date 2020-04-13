//
//  NewsItemView.swift
//  NewsSwiftUI
//
//  Created by 1 on 16.02.2020.
//  Copyright © 2020 azharkova. All rights reserved.
//

import SwiftUI
import Combine

struct NewsItemView: View{
    
    @ObservedObject var model: NewsItemModel =  NewsItemModel()
    init(){}
    init(item: NewsItem) {
        self.init()
        self.model.setupData(item: item)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0){
            CachedLoaderImage(withURL: model.data.urlToImage ?? "")
            Text(model.data.title ?? "").font(.system(size: 22)).bold().padding(EdgeInsets(top: 20,leading: 20,bottom: 0,trailing: 20))
            Text(model.data.dateString).font(.system(size: 12)).padding(EdgeInsets(top: 10,leading: 20,bottom: 0,trailing: 10))
            Text(model.data.content ?? "").font(.system(size: 17)).padding(EdgeInsets(top: 10,leading: 20,bottom: 20,trailing: 20))
            Button(action: {
                UIApplication.shared.open(URL(string: self.model.data.url ?? "")!, options: [:], completionHandler: nil)
            }) {
                SmallText(text: "Show more").padding(EdgeInsets(top:20,leading: 20,bottom: 20,trailing: 20))
            }
            Spacer()
        }
        .navigationBarTitle(Text(""), displayMode: .inline)
        .navigationBarItems(trailing: Button(action: {
            self.model.updateFavorite()
        }){
            Image(model.data.favorite ? "favorite" : "unfavorite").frame(width: 20, height: 20, alignment: .topTrailing)
        })
            .fixedSize(horizontal: false, vertical: false).onAppear {
                self.model.setupContent()
        }
    }
    
}

extension NewsItemView: IModelView {
    var viewModel: IModel? {
        get {
            return model
        }
    }
}
