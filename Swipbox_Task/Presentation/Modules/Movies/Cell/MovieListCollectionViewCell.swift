//
//  MovieListCollectionViewCell.swift
//  Swipbox_Task
//
//  Created by Muneeb Ali on 22/09/2024.
//

import UIKit


class MovieListCollectionViewCell: CollectionViewCell {
    
    //MARK: - UIElements
    let dataView = View(backgroundColor: .white, cornerRadius: 10.autoSized)
    let contentImageView = ImageView(imageName: "Logo")
    let persentageLabel = Label(text: "0%", textcolor: .white, font: .systemFont(ofSize: 8.autoSized, weight: .medium), alignment: .center)
    let titleLabel = Label(text: "Movie Name", textcolor: .black, font: .systemFont(ofSize: 12.autoSized, weight: .heavy))
    let dateLabel = Label(text: "Movie Date", textcolor: .gray, font: .systemFont(ofSize: 10.autoSized, weight: .semibold))
    
    
    //MARK: - Nib Methods
    override func setViewUI() {
        addElementsToView()
        dataView.clipsToBounds = true
        setPersentageLabel()
    }
    
    
    fileprivate func addElementsToView() {
        addSubview(dataView)
        dataView.addSubview(contentImageView)
        dataView.addSubview(persentageLabel)
        dataView.addSubview(titleLabel)
        dataView.addSubview(dateLabel)
        
        NSLayoutConstraint.activate([
            ///dataView
            dataView.topAnchor.constraint(equalTo: topAnchor),
            dataView.bottomAnchor.constraint(equalTo: bottomAnchor),
            dataView.leadingAnchor.constraint(equalTo: leadingAnchor),
            dataView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            ///contentImageView
            contentImageView.topAnchor.constraint(equalTo: dataView.topAnchor),
            contentImageView.leadingAnchor.constraint(equalTo: dataView.leadingAnchor),
            contentImageView.trailingAnchor.constraint(equalTo: dataView.trailingAnchor),
            contentImageView.heightAnchor.constraint(equalTo: dataView.heightAnchor, multiplier: 0.8),
            
            ///persentageLabel
            persentageLabel.centerYAnchor.constraint(equalTo: contentImageView.bottomAnchor),
            persentageLabel.leadingAnchor.constraint(equalTo: contentImageView.leadingAnchor, constant: 5.autoSized),
            persentageLabel.heightAnchor.constraint(equalToConstant: 30.autoSized),
            persentageLabel.widthAnchor.constraint(equalToConstant: 30.autoSized),
            
            ///titleLabel
            titleLabel.topAnchor.constraint(equalTo: persentageLabel.bottomAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: contentImageView.leadingAnchor, constant: 5.autoSized),
            titleLabel.trailingAnchor.constraint(equalTo: contentImageView.trailingAnchor),
            
            ///dateLabel
            dateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            dateLabel.bottomAnchor.constraint(equalTo: dataView.bottomAnchor, constant: -10),
            dateLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor, constant: 5.autoSized),
            dateLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            
        ])
        
        shadow(color: .gray)
    }
    
    // MARK: - Setup Method
    func setPersentageLabel() {
        persentageLabel.backgroundColor = .black
        persentageLabel.clipsToBounds = true
        persentageLabel.layer.cornerRadius = 15.autoSized
        persentageLabel.layer.borderWidth = 1.autoSized
        persentageLabel.layer.borderColor = UIColor.white.cgColor
    }
    
    func setData(_ data: Movie) {
        if let imageUrl = data.poster_path {
            ImageDownloadService.getImage(urlString: AppConfiguration().imageBaseURL + imageUrl) { [weak self] image in
                self?.contentImageView.image = image
            }
        } else {
            self.contentImageView.image = UIImage(named: "Logo")
        }
        let persentage = Int(((data.vote_average ?? 0.0) / 10.0) * 100)
        persentageLabel.text = "\(persentage)%"
        titleLabel.text = data.title
        dateLabel.text = data.release_date
    }
}
