//
//  NewsListRow.swift
//  NewsSwiftUI
//
//  Created by 1 on 16.02.2020.
//  Copyright © 2020 azharkova. All rights reserved.
//

import Foundation
import SwiftUI

struct NewsItemRow: View {
    @State var data: NewsItem
    var action: ((String)->Void)
    
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading,spacing: 10) {
                    HeaderText(text: data.title ?? "")
                    SubheaderText(text: data.description ?? "")
                    SmallText(text: data.publishedAt?.formatToString("dd.MM.yyyy") ?? "")
                }
                .fixedSize(horizontal: false,
                           vertical: true)
                ZStack {
                    ThumbImage(withURL: data.urlToImage ?? "")
                    Button(action:{
                        self.action(self.data.uuid)
                    }) {Image(self.data.favorite ? "favorite" : "unfavorite").colorMultiply(.white).frame(width: 20, height: 20, alignment: .topTrailing)}.offset(x: 50, y: -50)
                }
            }
            .padding(.all,8)
            .fixedSize(horizontal: false,
                       vertical: true)
            
            Divider()
        }
        .background(Color.white)
    }
}
