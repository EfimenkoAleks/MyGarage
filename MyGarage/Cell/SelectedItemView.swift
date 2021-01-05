//
//  SelectedItemView.swift
//  MyGarage
//
//  Created by mac on 24.12.2020.
//  Copyright © 2020 mac. All rights reserved.
//

import SwiftUI

struct SelectedItemView: View {
    
    var item: SelectedItem
    
    var body: some View {
        HStack{
            Image(item.name)
                .resizable()
                .renderingMode(.original)
                .aspectRatio(contentMode: .fit)
                .frame(width:80, height: 80)
            VStack(alignment: .leading) {
                Text(item.name)
                    .font(.subheadline)
                    .fontWeight(.medium)
                Text(item.price)
                    .font(.subheadline)
                    .fontWeight(.medium)
                Text(item.count)
                    .font(.subheadline)
                    .fontWeight(.medium)
                Text(item.seller)
                    .font(.subheadline)
                    .fontWeight(.medium)
            }
        }
    }
}

//struct SelectedItemView_Previews: PreviewProvider {
//    static var previews: some View {
//        SelectedItemView(item: <#SelectedItem#>)
//    }
//}
