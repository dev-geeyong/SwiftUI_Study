# SwiftUI_Study

강의 1, 2

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

ForEach(0..<emojis.count, id: \.self) { index in} // 반복문





강의 3


MVVM은 앱의 유지보수성과 확장성을 높이기 위한 디자인 패턴
	•	Model: 데이터와 비즈니스 로직을 담당
	•	View: 사용자에게 보여지는 UI
	•	ViewModel: Model과 View 사이에서 데이터 바인딩과 상태 관리를 수행

이 패턴을 통해 코드의 의존성을 낮추고 테스트 가능성을 높일 수 있음

2. SwiftUI에서의 데이터 흐름 관리
SwiftUI는 선언형 프로그래밍 방식으로, 데이터의 변화에 따라 UI가 자동으로 업데이트됩니다. 이를 위해 여러 가지 **속성 래퍼(Property Wrapper)**를 사용

2.1 @State
	•	역할: View 내부에서 상태를 저장하고 관리
	•	특징: 값이 변경되면 해당 View가 자동으로 다시 렌더링

예제:
struct CounterView: View {
    @State private var count = 0
    var body: some View {
        VStack {
            Text("카운트: \(count)")
            Button("증가") {
                count += 1
            }
        }
    }
}

설명:
	•	count 변수는 @State로 선언되어 View의 상태를 유지
	•	버튼을 누를 때마다 count가 증가하고, Text가 업데이트

2.2 @Binding
	•	역할: 상위 View의 상태를 하위 View에서 읽고 수정할 수 있게 함
	•	특징: 양방향 데이터 바인딩을 제공

예제:
struct ParentView: View {
    @State private var isOn = false
    var body: some View {
        ToggleView(isOn: $isOn)
    }
}

struct ToggleView: View {
    @Binding var isOn: Bool
    var body: some View {
        Toggle("스위치", isOn: $isOn)
    }
}

설명:
	•	ParentView에서 $isOn을 통해 isOn 상태를 ToggleView에 전달
	•	ToggleView에서 @Binding을 사용하여 상태를 제어하고 UI에 반영

2.3 @ObservedObject와 ObservableObject
	•	역할: 클래스 객체의 상태 변화를 감지하고 View를 업데이트
	•	특징: @Published로 선언된 프로퍼티의 변화를 관찰

예제:
class UserSettings: ObservableObject {
    @Published var username: String = "Guest"
}

struct ContentView: View {
    @ObservedObject var settings = UserSettings()
    var body: some View {
        VStack {
            Text("안녕하세요, \(settings.username)님")
            TextField("이름 변경", text: $settings.username)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
        }
    }
}

설명:
	•	UserSettings 클래스는 ObservableObject 프로토콜을 채택
	•	username 프로퍼티가 변경되면 ContentView가 자동으로 업데이트

2.4 @EnvironmentObject
	•	역할: 앱 전역에서 공유되는 객체를 View에 주입
	•	특징: 여러 View에서 동일한 객체를 사용할 수 있음

예제:
class ThemeSettings: ObservableObject {
    @Published var primaryColor: Color = .blue
}

struct RootView: View {
    var body: some View {
        ContentView()
            .environmentObject(ThemeSettings())
    }
}

struct ContentView: View {
    @EnvironmentObject var theme: ThemeSettings
    var body: some View {
        Text("Hello, World!")
            .foregroundColor(theme.primaryColor)
    }
}

설명:
	•	ThemeSettings 객체를 environmentObject로 주입하여 하위 View에서 사용할 수 있음
	•	ContentView에서는 @EnvironmentObject로 theme에 접근

데이터 변경과 View 업데이트 메커니즘
	•	데이터 변경: ViewModel에서 @Published 프로퍼티가 변경됩니다.
	•	View 업데이트: @ObservedObject로 ViewModel을 관찰하고 있으므로, 데이터 변경 시 View가 자동으로 업데이트됩니다.
	•	상태 관리: View의 일시적인 상태(예: 사용자 입력)는 @State로 관리합니다.
베스트 프랙티스 및 팁
	•	파일 분리: 각 역할(Model, View, ViewModel)에 따라 파일을 분리하여 관리합니다.
	•	명확한 데이터 흐름: 데이터가 어떻게 이동하는지 명확하게 이해하고 설계합니다.
	•	재사용 가능한 컴포넌트: View를 작은 단위로 분리하여 재사용성을 높입니다.
	•	의존성 관리: ViewModel에 비즈니스 로직을 집중시키고, View는 UI 표현에만 집중합니다.

