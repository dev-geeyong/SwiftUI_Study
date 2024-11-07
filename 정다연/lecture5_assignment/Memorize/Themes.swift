//
//  Themes.swift
//  Memorize
//
//  Created by Dayeon Jung on 2024/11/07.
//

import SwiftUI

enum Themes {
  case person
  case activity
  case sign
  case place
  
  var name: String {
    switch self {
    case .person:
      return "사람 및 표정"
    case .activity:
      return "활동"
    case .sign:
      return "기호"
    case .place:
      return "장소"
    }
  }
  
  var emojis: [String] {
    switch self {
    case .person:
      return ["😃", "😇", "🤩", "🥸", "😤", "🤯", "🤗", "🤠"]
    case .activity:
      return ["🪂", "🛹", "🤿", "🧘‍♀️", "🚣", "🏂", "🏓"]
    case .sign:
      return ["💟", "☪️", "🈸", "💯", "🚳", "✅", "🛜", "❓", "🛗", "🆘"]
    case .place:
      return ["🎑", "🌅", "🌠", "🌌", "🌃", "🎆", "🌇"]
    }
  }
  
  var color: Color {
    switch self {
    case .person:
      return .cyan
    case .activity:
      return .gray
    case .sign:
      return .yellow
    case .place:
      return .orange
    }
  }
  
  var highlightColor: Color {
    switch self {
    case .person:
      return .blue
    case .activity:
      return .green
    case .sign:
      return .brown
    case .place:
      return .red
    }
  }
}
