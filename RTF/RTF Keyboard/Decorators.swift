//
//  Model.swift
//  RTFKeyboard
//
//  Created by Perekupko, Yuriy (Agoda) on 14/5/20.
//  Copyright © 2020 Yurko. All rights reserved.
//

import Foundation

extension String {
  
  func substring(fromIndex: Int) -> String {
    return self[min(fromIndex, count) ..< count]
  }
  
  subscript (r: Range<Int>) -> String {
    let range = Range(uncheckedBounds: (lower: max(0, min(count, r.lowerBound)),
                                        upper: min(count, max(0, r.upperBound))))
    let start = index(startIndex, offsetBy: range.lowerBound)
    let end = index(start, offsetBy: range.upperBound - range.lowerBound)
    return String(self[start ..< end])
  }
}

protocol Decorator {
  func decorate(text: String) -> String
  func undecorate(text: String) -> String
  func isDecoratable(text: String) -> Bool
  func isDecorated(text: String) -> Bool
}

class ConvertingDecoratorBase: Decorator {
  
  var ranges: [(String, String)] { get { [] } }
  
  private func getCode(c: Character?) -> UInt32 {
    c!.unicodeScalars.first!.value
  }
  
  private lazy var rangeCodes: [((UInt32, UInt32), (UInt32, UInt32))] = ranges.map { (from, to) in
    ((getCode(c: from.first), getCode(c: from.substring(fromIndex: 1).first)), (getCode(c: to.first), getCode(c: to.substring(fromIndex: 1).first)))
  }
  
  private func convert(text: String, isDecorate: Bool) -> String {
    String(text.map { c in
      rangeCodes.compactMap { range in
        let from = isDecorate ? range.0 : range.1
        let to = isDecorate ? range.1 : range.0
        let cCode = getCode(c: c)
        if from.0 <= cCode && cCode <= from.1 {
          return Character(UnicodeScalar(cCode - from.0 + to.0)!)
        } else {
          return nil
        }
      }.first ?? c
    })
  }
  
  final func decorate(text: String) -> String {
    convert(text: text, isDecorate: true)
  }
  
  final func undecorate(text: String) -> String {
    convert(text: text, isDecorate: false)
  }
  
  final func isDecoratable(text: String) -> Bool {
    decorate(text: text) != text
  }
  
  final func isDecorated(text: String) -> Bool {
    undecorate(text: text) != text
  }
}

class SansDecorator: ConvertingDecoratorBase {
  override var ranges: [(String, String)] {
    get { [("AZ", "𝗔𝗭"), ("az", "𝗮𝘇"), ("09", "𝟬𝟵")] }
  }
}

class SansBoldDecorator: ConvertingDecoratorBase {
  override var ranges: [(String, String)] {
    get { [("AZ", "𝗔𝗭"), ("az", "𝗮𝘇"), ("09", "𝟬𝟵")] }
  }
}

class SansItalicDecorator: ConvertingDecoratorBase {
  override var ranges: [(String, String)] {
    get { [("AZ", "𝘈𝘡"), ("az", "𝘢𝘻")] }
  }
}

class SansBoldItalicDecorator: ConvertingDecoratorBase {
  override var ranges: [(String, String)] {
    get { [("AZ", "𝘼𝙕"), ("az", "𝙖𝙯")] }
  }
}

class SerifDecorator: ConvertingDecoratorBase {
  override var ranges: [(String, String)] {
    get { [("AZ", "𝗔𝗭"), ("az", "𝗮𝘇"), ("09", "𝟬𝟵")] }
  }
}

class SerifBoldDecorator: ConvertingDecoratorBase {
  override var ranges: [(String, String)] {
    get { [("AZ", "𝗔𝗭"), ("az", "𝗮𝘇"), ("09", "𝟬𝟵")] }
  }
}

class SerifItalicDecorator: ConvertingDecoratorBase {
  override var ranges: [(String, String)] {
    get { [("AZ", "𝗔𝗭"), ("az", "𝗮𝘇"), ("09", "𝟬𝟵")] }
  }
}

class SerifBoldItalicDecorator: ConvertingDecoratorBase {
  override var ranges: [(String, String)] {
    get { [("AZ", "𝗔𝗭"), ("az", "𝗮𝘇"), ("09", "𝟬𝟵")] }
  }
}

class ScriptDecorator: ConvertingDecoratorBase {
  override var ranges: [(String, String)] {
    get { [("AZ", "𝗔𝗭"), ("az", "𝗮𝘇"), ("09", "𝟬𝟵")] }
  }
}

class ScriptBoldDecorator: ConvertingDecoratorBase {
  override var ranges: [(String, String)] {
    get { [("AZ", "𝗔𝗭"), ("az", "𝗮𝘇"), ("09", "𝟬𝟵")] }
  }
}

class FrakturDecorator: ConvertingDecoratorBase {
  override var ranges: [(String, String)] {
    get { [("AZ", "𝗔𝗭"), ("az", "𝗮𝘇"), ("09", "𝟬𝟵")] }
  }
}

class FrakturBoldDecorator: ConvertingDecoratorBase {
  override var ranges: [(String, String)] {
    get { [("AZ", "𝗔𝗭"), ("az", "𝗮𝘇"), ("09", "𝟬𝟵")] }
  }
}

class DoubleStruckDecorator: ConvertingDecoratorBase {
  override var ranges: [(String, String)] {
    get { [("AZ", "𝗔𝗭"), ("az", "𝗮𝘇"), ("09", "𝟬𝟵")] }
  }
}

class MonospaceDecorator: ConvertingDecoratorBase {
  override var ranges: [(String, String)] {
    get { [("AZ", "𝗔𝗭"), ("az", "𝗮𝘇"), ("09", "𝟬𝟵")] }
  }
}
