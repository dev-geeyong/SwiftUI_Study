# SwiftUI_Study

## 강의 1, 2
swiftUI 에서는 객체지향의 개념인 슈퍼클래스라는 개념이 없다. 함수형 프로그래밍에 기반을 두고 있기 때문이다
<!-- 주석 -->
UI구성의 내용이 담긴 ContentView는 결국 View 구조체이며, 이러한 구조체 안에는 여러 가지 변수, 메서드를 담아낼 수 있다.
<!-- 주석 -->
ContentView의 body는 변수로 선언이 되어있지만, 메모리에 저장되지 않는다
<!-- 주석 -->
body에 접근할 때마다 body 뒤에 이어진 { ... } 블록의 해당 함수 내용을 수행하고 반환되는 결과를 받아 오는 것이다.
<!-- 주석 -->
이는 swift의 큰 특징 중 하나인 함수형 프로그래밍에 의한 표현으로 볼 수 있다
<!-- 주석 -->
@State 
특정 상태를 나타냄
뷰 내부에서만 사용가능
해당 값이 변경되면 view 를 다시 랜더링 
https://developer.apple.com/documentation/swiftui/state
<!-- 주석 -->
var body: some View {}
some View는 무슨의미인가 "View처럼 행동하는 무언가라는 정의" 어떤 형식의 View 로 구성이 될지모르니 some View 타입으로 표현
<!-- 주석 -->
ZStack {} 
스크린 - 사용자 방향 순서로 view를 결합하는 기능을 수행
<!-- 주석 -->
Group {} 여러뷰를 하나의 단위로 묶을 수 있음
<!-- 주석 -->
```swift
Button(action: {} // 버튼 누르면 실행
}, label: {}) // 버튼 타이틀
```
<!-- 주석 -->
```swift
ForEach(0..<emojis.count, id: \.self) { index in} // 반복문
```




## 강의 3, 4
### 1. MVVM은 앱의 유지보수성과 확장성을 높이기 위한 디자인 패턴
<!-- 주석 -->
	•	Model: 데이터와 비즈니스 로직을 담당
	•	View: 사용자에게 보여지는 UI
	•	ViewModel: Model과 View 사이에서 데이터 바인딩과 상태 관리를 수행

이 패턴을 통해 코드의 의존성을 낮추고 테스트 가능성을 높일 수 있음
<!-- 주석 -->
### 2. SwiftUI에서의 데이터 흐름 관리
SwiftUI는 선언형 프로그래밍 방식으로, 데이터의 변화에 따라 UI가 자동으로 업데이트
이를 위해 여러 가지 **속성 래퍼(Property Wrapper)**를 사용
<!-- 주석 -->
2.1 @State
<!-- 주석 -->
	•	역할: View 내부에서 상태를 저장하고 관리
	•	특징: 값이 변경되면 해당 View가 자동으로 다시 렌더링

예제:
```swift
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
```
설명:
<!-- 주석 -->
	•	count 변수는 @State로 선언되어 View의 상태를 유지
	•	버튼을 누를 때마다 count가 증가하고, Text가 업데이트

2.2 @Binding
<!-- 주석 -->
	•	역할: 상위 View의 상태를 하위 View에서 읽고 수정할 수 있게 함
	•	특징: 양방향 데이터 바인딩을 제공

예제:
```swift
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
```
설명:
<!-- 주석 -->
	•	ParentView에서 $isOn을 통해 isOn 상태를 ToggleView에 전달
	•	ToggleView에서 @Binding을 사용하여 상태를 제어하고 UI에 반영
<!-- 주석 -->
2.3 @ObservedObject와 ObservableObject
<!-- 주석 -->
	•	역할: 클래스 객체의 상태 변화를 감지하고 View를 업데이트
	•	특징: @Published로 선언된 프로퍼티의 변화를 관찰

예제:
```swift
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
```
설명:
<!-- 주석 -->
	•	UserSettings 클래스는 ObservableObject 프로토콜을 채택
	•	username 프로퍼티가 변경되면 ContentView가 자동으로 업데이트
<!-- 주석 -->
2.4 @EnvironmentObject
<!-- 주석 -->
	•	역할: 앱 전역에서 공유되는 객체를 View에 주입
	•	특징: 여러 View에서 동일한 객체를 사용할 수 있음

예제:
```swift
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
```
<!-- 주석 -->
설명:
<!-- 주석 -->
	•	ThemeSettings 객체를 environmentObject로 주입하여 하위 View에서 사용할 수 있음
	•	ContentView에서는 @EnvironmentObject로 theme에 접근

데이터 변경과 View 업데이트 메커니즘
<!-- 주석 -->
	•	데이터 변경: ViewModel에서 @Published 프로퍼티가 변경
	•	View 업데이트: @ObservedObject로 ViewModel을 관찰하고 있으므로, 데이터 변경 시 View가 자동으로 업데이트
	•	상태 관리: View의 일시적인 상태(예: 사용자 입력)는 @State로 관리
베스트 프랙티스 및 팁
<!-- 주석 -->
	•	파일 분리: 각 역할(Model, View, ViewModel)에 따라 파일을 분리하여 관리
	•	명확한 데이터 흐름: 데이터가 어떻게 이동하는지 명확하게 이해하고 설계
	•	재사용 가능한 컴포넌트: View를 작은 단위로 분리하여 재사용성을 높임
	•	의존성 관리: ViewModel에 비즈니스 로직을 집중시키고, View는 UI 표현에만 집중
# 5강

---

## Layout (레이아웃)

### SwiftUI의 Layout

- **Container Views**는 자식 뷰에 공간을 "제공"
- 자식 **Views**는 자신이 원하는 크기를 선택 (오직 자식 뷰만이 이를 결정할 수 있다).
- **Container Views**는 제공한 공간 내에서 자식 뷰들을 배치

### HStack과 VStack

- 스택은 제공받은 공간을 하위 뷰에게 나누어준다.
- 가장 "유연하지 않은"(고정된 크기를 선호하는) 뷰부터 공간을 배정
- 예: **Image**는 고정된 크기를 선호, **Text**는 텍스트에 맞춰 크기를 조정, **RoundedRectangle**은 제공된 모든 공간을 사용
- 유연한 뷰들은 공유된 공간을 균등하게 나눈다
- **Spacer**와 **Divider**는 스택 내부에서 공간을 나누는 중요한 역할

### 예시 코드

```swift
HStack {
    Image(systemName: "star.fill")
    Text("Hello World")
    RoundedRectangle(cornerRadius: 10)
}
```
- 위 코드에서 **HStack**은 **Image**, **Text**, **RoundedRectangle**을 포함하고 있으며, 각각 제공받은 공간을 적절히 나눔

### LazyHStack과 LazyVStack

- **Lazy** 버전의 스택은 보이지 않는 뷰를 생성하지 않음
- **ScrollView**와 함께 사용될 때 유용

### ZStack

- 자식 뷰를 겹쳐서 배치
- 하나의 자식 뷰가 완전히 유연하다면, ZStack 자체도 유연

```swift
ZStack {
    Color.blue
    Text("Hello ZStack")
        .foregroundColor(.white)
}
```
- **ZStack**은 **Color**와 **Text**를 겹쳐서 배치

### Modifiers

- **View Modifier**는 새로운 뷰를 반환
- **.padding**, **.aspectRatio** 등의 modifier는 뷰의 레이아웃에도 관여할 수 있다

---

## @ViewBuilder

`@ViewBuilder`는 Swift에서 **var**에 특별한 기능을 추가하기 위한 메커니즘을 기반으로 한다. 이것은 여러 개의 **View**를 보다 편리한 문법으로 작성할 수 있게 해준다

- **@ViewBuilder**는 **list of Views**로 해석하여 하나의 **View**로 결합
- 조건문을 사용해 특정 조건에 따라 다른 뷰를 반환할 수 있으며, 여러 개의 **View**들을 하나로 묶어준다

```swift
@ViewBuilder
func front(of card: Card) -> some View {
    RoundedRectangle(cornerRadius: 20)
        .fill(.white)
        .overlay(Text(card.content))
}
```
- 함수나 읽기 전용 계산 속성에 **@ViewBuilder**를 적용할 수 있다

### 조건부 View 처리

- `if-else`, `switch`, `if let`과 같은 조건문을 사용해 **View**를 포함하거나 제외할 수 있다

```swift
@ViewBuilder
var someView: some View {
    if someCondition {
        Text("Condition is true")
    } else {
        Text("Condition is false")
    }
}
```
---

## Shape

SwiftUI에서 커스텀 도형을 그리기 위해 **Shape** 프로토콜을 사용할 수 있다.

- 직접 도형을 정의하고 **Canvas**에 그릴 수 있으며, 이로써 다양한 커스텀 도형을 만들 수 있다.

```swift
struct Pie: Shape {
    var startAngle: Angle
    var endAngle: Angle
    var clockwise: Bool

    func path(in rect: CGRect) -> Path {
        var path = Path()
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height) / 2
        path.move(to: center)
        path.addArc(center: center,
                    radius: radius,
                    startAngle: startAngle,
                    endAngle: endAngle,
                    clockwise: !clockwise)
        path.closeSubpath()
        return path
    }
}
```

# 6강
---

## Enums (열거형)

**Enum**은 데이터 구조의 또 다른 형태로서 `struct`와 `class` 외에 사용할 수 있다. `enum`은 유한한 상태를 가질 수 있으며, 각 상태는 구분되는 값

```swift
enum FastFoodMenuItem {
    case hamburger
    case fries
    case drink
    case cookie
}
```

- **Enum은 값 타입(Value Type)**이며, `struct`와 마찬가지로 복사

### Associated Data (연관 데이터)

각 상태는 연관 데이터를 가질 수 있음

```swift
enum FastFoodMenuItem {
    case hamburger(numberOfPatties: Int)
    case fries(size: FryOrderSize)
    case drink(String, ounces: Int)
    case cookie
}
```

- 예를 들어, `drink`는 두 개의 연관 데이터를 가질 수 있음 (브랜드명과 용량).
- `FryOrderSize`와 같은 데이터도 별도의 `enum`으로 정의

### Enum의 값 설정

Swift는 값의 타입을 추론할 수 있지만, 명시적으로 설정하지 않으면 추론에 실패할 수 있다

```swift
let menuItem = FastFoodMenuItem.hamburger(numberOfPatties: 2)
var otherItem: FastFoodMenuItem = .cookie
```

아래와 같은 코드는 오류가 발생

```swift
var yetAnotherItem = .cookie // 오류 발생
```

### Enum 상태 확인

`switch` 구문을 사용하여 `enum`의 상태를 확인할 수 있다

```swift
var menuItem = FastFoodMenuItem.hamburger(numberOfPatties: 2)
switch menuItem {
    case .hamburger: print("burger")
    case .fries: print("fries")
    case .drink: print("drink")
    case .cookie: print("cookie")
}
```

Swift는 `FastFoodMenuItem` 타입을 추론할 수 있으므로 `switch`에서 완전한 이름을 사용할 필요가 없다

### `break`와 `default`

- `break`: 특정 케이스에서 아무 작업도 하지 않으려면 `break`를 사용
- `default`: 모든 케이스를 처리하지 않으려면 `default`를 사용하여 나머지 케이스를 처리

### Multiple Lines Allowed

각 `switch` 케이스에서 여러 줄의 코드를 사용할 수 있으며, 다음 케이스로 넘어가지 않는다

```swift
switch menuItem {
    case .hamburger: print("burger")
    case .fries:
        print("yummy")
        print("fries")
    case .drink: print("drink")
    case .cookie: print("cookie")
}
```

### Associated Data 접근

연관 데이터는 `switch` 구문과 `let` 구문을 사용하여 접근할 수 있다

```swift
var menuItem = FastFoodMenuItem.drink("Coke", ounces: 32)
switch menuItem {
    case .hamburger(let pattyCount): print("a burger with \(pattyCount) patties!")
    case .fries(let size): print("a \(size) order of fries!")
    case .drink(let brand, let ounces): print("a \(ounces)oz \(brand)")
    case .cookie: print("a cookie!")
}
```

### Methods와 Properties

- **메서드**는 열거형 내에 정의할 수 있지만, **저장 속성(stored property)**는 가질 수 없다. 대신 **계산 속성(computed property)**는 가능


```swift
enum FastFoodMenuItem {
    case hamburger(numberOfPatties: Int)
    case fries(size: FryOrderSize)
    case drink(String, ounces: Int)
    case cookie

    func isIncludedInSpecialOrder(number: Int) -> Bool {
        switch self {
        case .hamburger(let pattyCount): return pattyCount == number
        case .fries, .cookie: return true
        case .drink(_, let ounces): return ounces == 16
        }
    }
}
```

### All Cases of an Enumeration

모든 열거형의 케이스를 반복하려면 `CaseIterable` 프로토콜을 사용

```swift
enum TeslaModel: CaseIterable {
    case X
    case S
    case Three
    case Y
}

for model in TeslaModel.allCases {
    reportSalesNumbers(for: model)
}
```

---

## Optionals (옵셔널)

옵셔널은 Swift에서 매우 중요한 타입이며, 사실 열거형(`enum`)

```swift
enum Optional<T> {
    case none
    case some(T)
}
```

옵셔널은 두 가지 값만 가질 수 있다: 값이 설정된 경우(`some`)와 설정되지 않은 경우(`none`).

### 옵셔널 선언

옵셔널 타입을 선언하려면 `T?` 문법을 사용

```swift
var hello: String? = "hello"
var hello: String? = nil
```

옵셔널은 항상 기본적으로 `nil`로 시작

### 옵셔널 값 접근

옵셔널의 값을 접근할 때는 강제 추출(`!`)을 사용하거나 안전하게 추출하려면 `if let`을 사용

```swift
let hello: String? = ...
print(hello!) // 강제 추출 (비추천, 위험)

if let hello = hello {
    print(hello)
} else {
    // 다른 작업 수행
}
```

또는 `switch` 구문을 사용하여 옵셔널의 상태를 확인할 수 있다

### Nil-Coalescing Operator (`??`)

옵셔널이 `nil`일 경우 기본 값을 설정하려면 `??` 연산자를 사용

```swift
let x: String? = ...
let y = x ?? "foo"
```

# 7강

1. **Demo Interlude**
   - **뷰 분리**: `CardView`를 별도의 Swift 파일로 분리.
   - **상수 처리**: Swift 코드 내에서 상수를 처리하는 방법.

   ```swift
   // CardView.swift
   struct CardView: View {
       var card: Card

       var body: some View {
           ZStack {
               if card.isFaceUp {
                   RoundedRectangle(cornerRadius: 10).fill(Color.white)
                   RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 3)
                   Text(card.content)
               } else {
                   RoundedRectangle(cornerRadius: 10).fill()
               }
           }
       }
   }
   ```

2. **Shape**
   - **커스텀 도형 그리기**: SwiftUI에서 도형을 직접 정의.
   - **Pie 모양 카운트다운 타이머**를 카드 위에 그리기 (애니메이션 없음).

   ```swift
   struct Pie: Shape {
       var startAngle: Angle
       var endAngle: Angle
       var clockwise: Bool

       func path(in rect: CGRect) -> Path {
           var path = Path()
           let center = CGPoint(x: rect.midX, y: rect.midY)
           let radius = min(rect.width, rect.height) / 2
           path.move(to: center)
           path.addArc(center: center,
                       radius: radius,
                       startAngle: startAngle,
                       endAngle: endAngle,
                       clockwise: !clockwise)
           return path
       }
   }
   ```

3. **Animation**
   - **애니메이션이란 무엇인가?**
   - **뷰의 애니메이션 적용**: `ViewModifiers`를 사용해 뷰에 애니메이션을 적용.

   ```swift
   @State private var isAnimating = false

   var body: some View {
       Circle()
           .fill(isAnimating ? Color.red : Color.blue)
           .frame(width: 100, height: 100)
           .onTapGesture {
               withAnimation {
                   isAnimating.toggle()
               }
           }
   }
   ```

4. **ViewModifier**
   - **ViewModifier 사용법**: `modifier()` 메소드를 사용해 뷰에 모디파이어 적용.
   - **카드 스타일링**: `Cardify` 모디파이어를 사용해 카드 스타일 적용.

   ```swift
   struct Cardify: ViewModifier {
       var isFaceUp: Bool

       func body(content: Content) -> some View {
           ZStack {
               if isFaceUp {
                   RoundedRectangle(cornerRadius: 10).fill(Color.white)
                   RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 3)
                   content
               } else {
                   RoundedRectangle(cornerRadius: 10).fill()
               }
           }
       }
   }

   extension View {
       func cardify(isFaceUp: Bool) -> some View {
           self.modifier(Cardify(isFaceUp: isFaceUp))
       }
   }
   ```

5. **Swift Type System**
   - **프로토콜**
     - 코드 공유를 촉진하는 목적으로 사용.
     - 프로토콜에 **extension**을 추가해 구현을 확장할 수 있음.

   ```swift
   protocol Identifiable {
       var id: String { get }
   }

   extension Identifiable {
       func describe() -> String {
           return "ID: \(id)"
       }
   }
   ```

6. **Generics + Protocols**
   - **제네릭 타입과 프로토콜**의 조합을 활용해 코드의 유연성을 증가.
   - **Identifiable** 프로토콜의 `associatedtype`을 통해 특정 타입 제약 적용.

   ```swift
   protocol Identifiable {
       associatedtype ID: Hashable
       var id: ID { get }
   }

   struct User: Identifiable {
       var id: String
   }
   ```

7. **some 키워드**
   - **`some` 키워드**를 사용해 반환 타입을 불투명하게 설정.

   ```swift
   func createShape(rounded: Bool) -> some Shape {
       if rounded {
           return RoundedRectangle(cornerRadius: 10)
       } else {
           return Circle()
       }
   }
   ```

   - **뷰 빌더와의 차이**: `@ViewBuilder`는 항상 같은 타입을 반환해야 함.


8. **any 키워드**
   - **다형성 배열** 생성 시 사용.
   - **Heterogeneous Collection**을 생성하는 데 유용함.

   ```swift
   let items: [any Identifiable] = [User(id: "123"), User(id: "456")]
   ```
    }
  ]
}

# 8강


# 10강 Assignment

## Swift Programming Language

### 1. 문자열과 문자 (Strings and Characters)
- `String`은 Swift의 기본적인 텍스트 데이터 타입임. Unicode 지원으로 다국어 텍스트를 안정적으로 처리할 수 있음.
- 문자열은 값 타입이며, 메모리 효율성을 높이고 안전성을 보장함.
- 문자열 연결은 `+` 연산자로 가능하며, 문자열 보간법(`\(변수)`)으로 가독성 높은 문자열 생성 가능함.
- 예시:
  ```swift
  let greeting = "Hello"
  let name = "Alice"
  let fullGreeting = "\(greeting), \(name)!" // "Hello, Alice!"
  ```
- `Character` 타입은 하나의 문자 단위를 나타냄. `String`은 `Character`의 배열로 구성됨.
- 문자열의 각 문자는 반복문을 통해 순회 가능함.
  ```swift
  for char in "Hello" {
      print(char) // H e l l o
  }
  ```

### 2. 제어 흐름 (Control Flow)
- 조건문은 `if`, `guard`, `switch`를 사용함. `if-else`는 기본적인 분기 처리에 사용되며, `guard`는 조기 탈출에 유용함.
  ```swift
  let age = 20
  if age >= 18 {
      print("Adult")
  } else {
      print("Minor")
  }

  func checkName(_ name: String?) {
      guard let validName = name else {
          print("Name is nil")
          return
      }
      print("Hello, \(validName)")
  }
  ```
- 반복문은 `for-in`, `while`, `repeat-while`을 사용함. `continue`와 `break`를 통해 제어 흐름을 조절함.
- 레이블이 있는 구문(`Labeled Statements`)은 중첩된 루프에서 특정 루프를 종료하거나 계속할 때 사용함.
  ```swift
  outerLoop: for i in 1...5 {
      for j in 1...5 {
          if j == 3 {
              continue outerLoop
          }
          print("\(i), \(j)")
      }
  }
  ```

### 3. 열거형 (Enumerations)
- 열거형은 연관된 값의 그룹을 정의함. 각 열거형 케이스는 `Int`, `String` 등 원시 값을 가질 수 있음.
- 열거형은 `case` 키워드로 정의되며, 메서드나 계산 프로퍼티를 포함할 수 있음.
  ```swift
  enum Direction {
      case north
      case south
      case east
      case west
  }

  let move = Direction.north
  switch move {
  case .north:
      print("Go North")
  default:
      print("Other direction")
  }
  ```
- 재귀 열거형은 `indirect` 키워드를 사용해 정의 가능하지만, 복잡성을 높이므로 피하는 것이 좋음.

### 4. 상속 및 초기화 (Inheritance and Initialization)
- 클래스는 부모 클래스를 상속받아 코드 재사용성을 높임. SwiftUI에서는 상속보다는 구조체와 프로토콜 지향 설계가 선호됨.
  ```swift
  class Vehicle {
      var currentSpeed = 0.0
      func describe() -> String {
          return "Traveling at \(currentSpeed) miles per hour"
      }
  }

  class Car: Vehicle {
      var hasSunroof = false
  }

  let myCar = Car()
  myCar.currentSpeed = 50.0
  print(myCar.describe()) // "Traveling at 50.0 miles per hour"
  ```
- 클래스의 초기화는 `init()` 메서드로 정의하며, `required` 키워드는 하위 클래스에서 필수 구현을 의미함.

### 5. 소멸화 (Deinitialization)
- 클래스 인스턴스가 메모리에서 해제될 때 `deinit` 메서드가 호출됨. 주로 리소스 해제 작업에 사용함.
  ```swift
  class FileHandler {
      var fileName: String
      init(fileName: String) {
          self.fileName = fileName
          print("Opening file: \(fileName)")
      }

      deinit {
          print("Closing file: \(fileName)")
      }
  }

  var handler: FileHandler? = FileHandler(fileName: "data.txt")
  handler = nil // "Closing file: data.txt" 출력
  ```

### 6. 타입 캐스팅 (Type Casting)
- 타입을 확인하거나 다른 타입으로 변환할 때 사용됨. `as?`와 `as!` 연산자는 안전한 다운캐스팅과 강제 다운캐스팅을 의미함.
  ```swift
  class Animal {}
  class Dog: Animal {}

  let pet: Animal = Dog()
  if let dog = pet as? Dog {
      print("This is a dog")
  } else {
      print("This is not a dog")
  }
  ```
- 프로토콜과 제네릭을 사용해 타입 캐스팅을 최소화하는 것이 권장됨.

### 7. 프로토콜 (Protocols)
- 클래스와 구조체가 특정 기능을 구현하도록 요구하는 청사진 역할을 함. `optional` 요구사항은 `@objc`와 함께 사용되며 UIKit과의 호환성을 위해 제공됨.
  ```swift
  protocol Greetable {
      func greet()
  }

  class Person: Greetable {
      func greet() {
          print("Hello!")
      }
  }
  ```

### 8. 자동 참조 카운팅 (Automatic Reference Counting)
- 참조 타입 객체의 메모리 관리를 자동으로 수행함. 강한(`strong`), 약한(`weak`), 비소유(`unowned`) 참조를 통해 메모리 누수를 방지함.

### 9. 메모리 안전성 (Memory Safety)
- Swift는 메모리 접근이 중복되지 않도록 안전하게 관리함. 예외적인 상황에서 로우 레벨 데이터 조작이 필요한 경우 이해가 필요함.
  ```swift
  var number = 5
  withUnsafeMutablePointer(to: &number) { pointer in
      pointer.pointee += 1
  }
  print(number) // 6
  ```

### 10. 접근 제어 (Access Control)
- 모듈 내 코드의 가시성을 제어함. `open`, `public`, `internal`, `fileprivate`, `private` 접근 수준을 제공함.
- 서브클래싱과 확장에서 접근 제어를 적절히 설정해 보안과 모듈성을 유지함.

## Swift API Guidelines 요약

### 1. 문서 주석 작성하기 (Write a documentation comment)
- 코드를 설명하는 주석을 명확하고 간결하게 작성합니다.
- 읽는 사람이 코드를 쉽게 이해할 수 있도록 의도를 명확히 표현해야 합니다.
- 공통 포맷을 따르고, 적절한 문법과 스타일을 사용합니다.

### 2. 케이스 규칙 따르기 (Follow case conventions)
- Swift에서는 camelCase를 사용합니다.
- 타입과 프로토콜 이름은 대문자로 시작하고, 함수 및 변수 이름은 소문자로 시작합니다.
- 약어는 통일성을 유지하며, 전체 단어를 사용하는 것이 권장됩니다.

### 3. 매개변수 레이블 (Argument Labels)
- 함수 및 메서드에서 매개변수 레이블은 함수 호출 시 의도가 명확하게 보이도록 만듭니다.
- 첫 번째 매개변수는 함수 이름과 자연스럽게 연결되도록 설계합니다.
- 불필요한 레이블은 제거하여 간결하게 유지합니다.

### 4. Unconstrained Polymorphism 무시 가능
- `Any` 및 `AnyObject`와 같은 타입은 다루지 않아도 됩니다.
