//
//  AspectVGrid.swift
//  Memorize
//
//  Created by Dayeon Jung on 2024/11/06.
//

import SwiftUI

struct AspectVGrid<Item: Identifiable, ItemView: View>: View {
  var items: [Item]
  var aspectRatio: CGFloat = 1
  var content: (Item) -> ItemView
  
  init(_ items: [Item], aspectRatio: CGFloat, content: @escaping (Item) -> ItemView) {
    self.items = items
    self.aspectRatio = aspectRatio
    self.content = content
  }
  
  var body: some View {
//    GeometryReader { geometry in
//      let gridItemSize = gridItemWidthThatFits(
//        count: items.count,
//        size: geometry.size,
//        atAspectRatio: aspectRatio)
      LazyVGrid(columns: [GridItem(.adaptive(minimum: 65), spacing: 0)], spacing: 0) {
        ForEach(items) { item in
          content(item)
            .aspectRatio(aspectRatio, contentMode: .fit)
        }
      }
//    }
  }
  
  // 주어진 공간 안에
  // 최대한 꽉차게 원하는 비율대로 그려질 수 있게 하는
  // 최소 가로 길이를 찾는 것
  func gridItemWidthThatFits(
    count: Int,
    size: CGSize,
    atAspectRatio aspectRatio: CGFloat
  ) -> CGFloat {
    let count = CGFloat(count)
    var columnCount = 1.0
    repeat {
      let width = size.width / columnCount
      let height = width / aspectRatio
      
      let rowCount = (count / columnCount).rounded(.up)
      if rowCount * height < size.height {
        return (size.width / columnCount).rounded(.down)
      }
      columnCount += 1
    } while columnCount < count
    return min(size.width / count, size.height * aspectRatio.rounded(.down))
  }
}
