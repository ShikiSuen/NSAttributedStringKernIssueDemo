//
//  ContentView.swift
//  NSAttributedStringKernIssueDemo
//
//  Created by ShikiSuen on 2023/10/11.
//

import SwiftUI

let sampleString = "「我要去上班」"

struct ContentView: View {
  @State var string1: NSAttributedString = {
    let result: NSMutableAttributedString = .init(string: sampleString)
    result.addAttributes([.font: NSFont.systemFont(ofSize: NSFont.systemFontSize)], range: .init(location: 0, length: sampleString.utf16.count))
    result.addAttributes([.backgroundColor: NSColor.systemRed], range: .init(location: 0, length: sampleString.utf16.count))
    result.addAttributes([.kern: 0], range: .init(location: 0, length: sampleString.utf16.count))
    return result
  }()

  @State var string2: NSAttributedString = {
    let result: NSMutableAttributedString = .init(string: sampleString)
    result.addAttributes([.font: NSFont.systemFont(ofSize: NSFont.systemFontSize)], range: .init(location: 0, length: sampleString.utf16.count))
    result.addAttributes([.backgroundColor: NSColor.systemRed], range: .init(location: 0, length: sampleString.utf16.count))
    return result
  }()

  var body: some View {
    Grid(alignment: .center) {
      GridRow {
        Text("[Expected] Kern manually set to 0:").frame(width: 300)
        TextFieldX($string1).frame(width: 100)
      }
      GridRow {
        Text("[Actual] Default kern in Sonoma 14.0:").frame(width: 300)
        TextFieldX($string2).frame(width: 100)
      }
    }
    .padding()
    .frame(width: 600, height: 250)
    .fixedSize()
  }
}

#Preview {
  ContentView()
}

// MARK: - TextFieldX

struct TextFieldX: NSViewRepresentable {
  @Binding var attrStr: NSAttributedString
  init(_ text: Binding<NSAttributedString>) {
    _attrStr = text
  }

  typealias NSViewType = NSTextField

  func makeNSView(context _: Context) -> NSTextField {
    let textField = NSTextField()
    textField.isSelectable = false
    textField.isEditable = false
    textField.isBordered = false
    textField.backgroundColor = .systemRed
    textField.allowsEditingTextAttributes = false
    textField.preferredMaxLayoutWidth = textField.frame.width
    textField.attributedStringValue = attrStr
    textField.setContentHuggingPriority(.defaultHigh, for: .vertical)
    textField.setContentHuggingPriority(.defaultLow, for: .horizontal)
    return textField
  }

  func updateNSView(_: NSTextField, context _: Context) {}
}
