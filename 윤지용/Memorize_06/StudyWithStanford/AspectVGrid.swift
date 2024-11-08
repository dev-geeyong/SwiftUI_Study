

import SwiftUI

struct AspectVGrid<Item: Identifiable, ItemView: View>: View {
    var items: [Item]
    var aspectRatio: CGFloat = 1
    var content: (Item) -> ItemView
//    @ViewBuilder
//    SwiftUI의 ViewBuilder는 여러 뷰를 결합하여 하나의 뷰를 만들 수 있게 해주는 기능
    init(_ items: [Item], aspectRatio: CGFloat, @ViewBuilder content: @escaping (Item) -> ItemView) {
        self.items = items
        self.aspectRatio = aspectRatio
        self.content = content
    }
//
    
    var body: some View {
        /*
            GeometryReader { geometry in
             geometry: GeometryProxy 인스턴스
             여기서 사용할 수 있는 정보:
             - geometry.size.width: 사용 가능한 너비
             - geometry.size.height: 사용 가능한 높이
             - geometry.safeAreaInsets: 안전 영역 여백
        }
        GeometryReader는 부모 뷰가 제공하는 공간의 크기 정보를 얻을 수 있게 해주는 SwiftUI의 컨테이너 뷰입니다.
         화면이 가로 모드로 회전하면
         geometry.size가 자동으로 업데이트되고
         gridItemSize가 새로 계산됨
         이렇게 GeometryReader를 사용함으로써:

         사용 가능한 화면 공간을 정확히 알 수 있음
         화면 크기에 따라 적절한 그리드 아이템 크기를 계산할 수 있음
         다양한 기기와 화면 방향에 대응하는 반응형 레이아웃을 만들 수 있음
        */
        GeometryReader { geometry in
            let gridItemSize = gridItemWidthThatFits(
                count: items.count,
                size: geometry.size,
                atAspectRatio: aspectRatio
            )
            LazyVGrid(columns: [GridItem(.adaptive(minimum: gridItemSize), spacing: 0)], spacing: 0) {
                ForEach(items) { item in // 저장된 클로저를 호출하여 각 아이템을 뷰로 변환
                    //재사용 가능한 그리드 컴포넌트를 만들 수
                    //각 아이템을 어떻게 표시할지 외부에서 정의할 수 있음

                    content(item)
                        .aspectRatio(aspectRatio, contentMode: .fit)
                }
            }
        }
    }
    
    func gridItemWidthThatFits(count: Int, size: CGSize, atAspectRatio aspectRatio: CGFloat) -> CGFloat {
        let count = CGFloat(count)
        var columnCount = 1.0
        
        repeat {
            let width = size.width / columnCount
            let height = width / aspectRatio
            
            let rowCount = (count/columnCount).rounded(.up)
            if rowCount * height < size.height {
                return (size.width / columnCount).rounded(.down)
            }
            
            columnCount += 1
            
        } while columnCount < count
        
        return min(size.width / count, size.height * aspectRatio).rounded(.down)
    }
}
