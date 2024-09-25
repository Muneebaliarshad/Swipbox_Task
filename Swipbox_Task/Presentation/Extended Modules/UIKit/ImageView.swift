//
//  ImageView.swift
//  Swipbox_Task
//
//  Created by Muneeb Ali on 22/09/2024.
//

import UIKit

class ImageView: UIImageView {
    
    //MARK: - Init Methods
    required init(imageName: String = "Logo", cornerRadius: CGFloat = 0.0, backgroundColor: UIColor = .clear, contentMode: ContentMode = .scaleAspectFill) {
        super.init(frame: .zero)
        super.translatesAutoresizingMaskIntoConstraints = false
        
        image = UIImage(named: imageName)
        self.backgroundColor = backgroundColor
        self.layer.cornerRadius = cornerRadius.autoSized
        self.contentMode = contentMode
        clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
