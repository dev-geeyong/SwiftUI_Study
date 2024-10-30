# SwiftUI_Study

강의 1

swiftUI 에서는 객체지향의 개념인 슈퍼클래스라는 개념이 없다. 함수형 프로그래밍에 기반을 두고 있기 때문이다
UI구성의 내용이 담긴 ContentView는 결국 View 구조체이며, 이러한 구조체 안에는 여러 가지 변수, 메서드를 담아낼 수 있다.
ContentView의 body는 변수로 선언이 되어있지만, 메모리에 저장되지 않는다
body에 접근할 때마다 body 뒤에 이어진 { ... } 블록의 해당 함수 내용을 수행하고 반환되는 결과를 받아 오는 것이다.
이는 swift의 큰 특징 중 하나인 함수형 프로그래밍에 의한 표현으로 볼 수 있다

@State 
특정 상태를 나타냄
뷰 내부에서만 사용가능
해당 값이 변경되면 view 를 다시 랜더링 
https://developer.apple.com/documentation/swiftui/state

var body: some View {}
some View는 무슨의미인가 "View처럼 행동하는 무언가라는 정의" 어떤 형식의 View 로 구성이 될지모르니 some View 타입으로 표현

ZStack {} 
스크린 - 사용자 방향 순서로 view를 결합하는 기능을 수행

Group {} 여러뷰를 하나의 단위로 묶을 수 있음

Button(action: {} // 버튼 누르면 실행
}, label: {}) // 버튼 타이틀

ForEach(0..<emojis.count, id: \.self) { index in} 
반복문
