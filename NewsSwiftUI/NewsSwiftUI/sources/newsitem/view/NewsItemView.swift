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
    
    var output:INewsItemInteractor?
    @ObservedObject var model: NewsItemModel =  NewsItemModel()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0){
            CachedImage(withURL: model.data.urlToImage ?? "")
            Text(model.data.title ?? "").font(.system(size: 22)).bold().padding(EdgeInsets(top: 20,leading: 20,bottom: 0,trailing: 20))
            Text(model.data.publishedAt?.formatToString("dd.MM.yyyy") ?? "").font(.system(size: 12)).padding(EdgeInsets(top: 10,leading: 20,bottom: 0,trailing: 10))
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
            self.output?.updateFavorite()
        }){
            Image(model.data.favorite ? "favorite" : "unfavorite").frame(width: 20, height: 20, alignment: .topTrailing)
        })
            .fixedSize(horizontal: false, vertical: false).onAppear {
                self.output?.setupContent()
        }
    }
    
}

extension NewsItemView : INewsItemView  {
    
    func updateModel(data: Any?) {
        self.model.update(data: data)
    }
    
}
