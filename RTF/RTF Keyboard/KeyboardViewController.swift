//
//  KeyboardViewController.swift
//  RTF Keyboard
//
//  Created by Yuriy Perekupko on 16.05.2020.
//  Copyright © 2020 Yurko. All rights reserved.
//

import UIKit

class KeyboardViewController: UIInputViewController {
    
    @IBOutlet var keyboardView: UIView!
    
    @IBOutlet var nextKeyboardButton: UIButton!
    @IBOutlet weak var boldButton: UIButton!
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        // Add custom view sizing constraints here
    }
    
    @IBAction func makeBold(_ sender: Any) {
        let selection = textDocumentProxy.selectedText ?? ""
        let decorator = SansBoldDecorator()
        var bold = decorator.undecorate(text: selection)
        if bold == selection {
          bold = decorator.decorate(text: selection)
        }
        textDocumentProxy.insertText(bold)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let keyboardNib = UINib(nibName: "KeyboardView", bundle: nil)
        keyboardView = keyboardNib.instantiate(withOwner: self, options: nil)[0] as? UIView
        keyboardView.frame.size = view.frame.size
        view.addSubview(keyboardView)
        
        nextKeyboardButton.addTarget(self, action: #selector(handleInputModeList(from:with:)), for: .allTouchEvents)
        
    }
    
}
