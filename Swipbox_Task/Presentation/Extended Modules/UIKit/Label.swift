//
//  Label.swift
//  Swipbox_Task
//
//  Created by Muneeb Ali on 22/09/2024.
//

import UIKit

class Label : UILabel {
    
    //MARK: - Init Methods
    required  init(text: String, textcolor: UIColor, font: UIFont, alignment: NSTextAlignment = .natural, numberOfLines: Int = 1) {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.textColor = textcolor
        self.font = UIFont(name: (font.fontName), size: CGFloat(Int(font.pointSize).autoSized))
        self.textAlignment = alignment
        self.numberOfLines = numberOfLines
        self.text = text
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
