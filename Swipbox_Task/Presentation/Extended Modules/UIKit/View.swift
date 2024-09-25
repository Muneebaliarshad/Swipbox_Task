//
//  View.swift
//  Swipbox_Task
//
//  Created by Muneeb Ali on 22/09/2024.
//

import UIKit

class View: UIView {
    
    //MARK: - Init Methods
    required init(backgroundColor: UIColor, cornerRadius: CGFloat = 0.0, borderColor: UIColor = .gray, borderWidth: CGFloat = 0) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = backgroundColor
        self.layer.cornerRadius = cornerRadius
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
