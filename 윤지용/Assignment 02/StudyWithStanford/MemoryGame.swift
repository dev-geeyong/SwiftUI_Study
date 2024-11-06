//
//  MemoryGame.swift
//  StudyWithStanford
//
//  Created by 윤지용 on 10/28/24.
// Model

import Foundation
import UIKit


struct MemoryGame<CardContent> where CardContent: Equatable { //CardContent 타입이 반드시 Equatable 프로토콜을 준수해야 한다는 조건을 붙인 것입니다
    private(set) var cards: Array<Card>
    private(set) var score: Int = 0
    private var seenCards: Set<String> = []  // 이전에 본 카드들의 ID를 추적
    var indexOfTheOneAndOnlyFacUpCard: Int? {
        get {
            let faceUpCardIndices = cards.indices.filter { index in cards[index].isFaceUp }
            return faceUpCardIndices.count == 1 ? faceUpCardIndices.first : nil
        }
        
        set {
            cards.indices.forEach { cards[$0].isFaceUp = (newValue == $0)}
        }
    }
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }) {
            if !cards[chosenIndex].isFaceUp && !cards[chosenIndex].isMatched { //뒤집어있고 매치된게 아니라면
                if let potentialMatchIndex = indexOfTheOneAndOnlyFacUpCard {
                    if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                        cards[chosenIndex].isMatched = true
                        cards[potentialMatchIndex].isMatched = true
                        score += 2
                    } else {
                        if seenCards.contains(cards[chosenIndex].id) {
                            score -= 1
                        }
                        if seenCards.contains(cards[potentialMatchIndex].id) {
                            score -= 1
                        }
                    }
                    seenCards.insert(cards[chosenIndex].id)
                    seenCards.insert(cards[potentialMatchIndex].id)
                } else {
                    indexOfTheOneAndOnlyFacUpCard = chosenIndex
                }
                cards[chosenIndex].isFaceUp = true
            }
        }
    }
    
    mutating func shuffle() {
        cards.shuffle()
    }
    
    init(item: Theme, createCardContent: (Int) -> CardContent) {
        cards = Array<Card>()
        
        for index in 0..<max(2,item.number) {
            let content = createCardContent(index)
            cards.append(Card(content: content, id: "\(index + 1)a", color: item.color, title: item.name))
            cards.append(Card(content: content, id: "\(index + 1)b", color: item.color, title: item.name))
        }
        cards.shuffle()
    }
    
    
    struct Card: Equatable, Identifiable {

        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent
        var id: String
        var color: UIColor
        var title: String
        
        
    }
}
struct Theme {
     let name: String
     let items: [String]
     let number: Int
     let color: UIColor
     
     // 테마 데이터를 static 프로퍼티로 Model 안에 정의
     static let all: [Theme] = [
        Theme(name: "Halloween",
              items: ["👻", "🎃", "🦇", "🧛", "⚰️", "🪄", "🔮", "🧿", "🦄", "🍭", "🧙", "🧌"],
              number: 12,
              color: UIColor.orange),
        
        Theme(name: "Animals",
              items: ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼", "🐨", "🐯", "🦁", "🐮"],
              number: 12,
              color: UIColor.brown),
        
        Theme(name: "Sports",
              items: ["⚽️", "🏀", "🏈", "⚾️", "🎾", "🏐", "🏉", "🎱", "🏓", "🏸", "🏒", "⛳️"],
              number: 12,
              color: UIColor.blue),
        
        Theme(name: "Food",
              items: ["🍎", "🍐", "🍊", "🍋", "🍌", "🍉", "🍇", "🍓", "🫐", "🍒", "🥝", "🍑"],
              number: 12,
              color: UIColor.red),
        
        Theme(name: "Weather",
              items: ["☀️", "🌤", "☁️", "🌧", "⛈", "🌩", "🌨", "❄️", "💨", "🌪", "☔️", "⚡️"],
              number: 8,
              color: UIColor.gray),
        
        Theme(name: "Space",
              items: ["🌎", "🌙", "⭐️", "☄️", "🚀", "🛸", "🌠", "🌌", "👨‍🚀", "🌍", "🌏", "🪐"],
              number: 12,
              color: UIColor.purple)
     ]
     
     // 랜덤 테마를 가져오는 static 메서드
     static func randomTheme() -> Theme {
         all.randomElement()!
     }
 }

/*
 ⚠️ mutating 없이 cards를 수정하려 하면 에러 발생
 struct는 값 타입이므로 기본적으로 불변(immutable)입니다
 struct의 메서드에서 프로퍼티를 변경하려면 mutating 키워드가 필요합니다
 mutating은 "이 메서드는 구조체의 상태를 변경할 수 있다"고 컴파일러에게 알려줍니다
 // 클래스 (참조 타입) - mutating 불필요
 */


//https://bbiguduk.gitbook.io/swift


