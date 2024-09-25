//
//  MovieDetailView.swift
//  Swipbox_Task
//
//  Created by Muneeb Ali on 24/09/2024.
//

import Foundation
import UIKit

class MovieDetailView: View {
    //MARK: - UIElements
    let bannerImageView = ImageView(imageName: "Logo")
    let shadowView = View(backgroundColor: .black.withAlphaComponent(0.7 ))
    let dataImageView = ImageView(imageName: "Logo", cornerRadius: 10.autoSized)
    let titleLabel = Label(text: "Movie Name", textcolor: .label, font: .systemFont(ofSize: 15.autoSized, weight: .heavy))
    let yearLabel = Label(text: "0000", textcolor: .systemGray, font: .systemFont(ofSize: 13.autoSized, weight: .regular))
    let persentageLabel = Label(text: "0%", textcolor: .systemBackground, font: .systemFont(ofSize: 10.autoSized, weight: .medium), alignment: .center)
    let overviewTitleLabel = Label(text: "Overview: ", textcolor: .label, font: .systemFont(ofSize: 15.autoSized, weight: .bold))
    let overviewLabel = Label(text: "0000", textcolor: .systemGray, font: .systemFont(ofSize: 15.autoSized, weight: .regular), numberOfLines: 0)
    let budgetTitleLabel = Label(text: "Budget: ", textcolor: .label, font: .systemFont(ofSize: 15.autoSized, weight: .bold))
    let budgetLabel = Label(text: "0000", textcolor: .systemGray, font: .systemFont(ofSize: 15.autoSized, weight: .regular))
    let revenueTitleLabel = Label(text: "Revenue: ", textcolor: .label, font: .systemFont(ofSize: 15.autoSized, weight: .bold))
    let revenueLabel = Label(text: "0000", textcolor: .systemGray, font: .systemFont(ofSize: 15.autoSized, weight: .regular))
    
    //MARK: - Setup Methods
    func setView() {
        addSubview(bannerImageView)
        addSubview(shadowView)
        addSubview(dataImageView)
        addSubview(titleLabel)
        addSubview(yearLabel)
        addSubview(persentageLabel)
        addSubview(overviewTitleLabel)
        addSubview(overviewLabel)
        addSubview(budgetTitleLabel)
        addSubview(budgetLabel)
        addSubview(revenueTitleLabel)
        addSubview(revenueLabel)
        
        setPersentageLabel()
        applyConstraints()
    }
    
    fileprivate func applyConstraints() {
        NSLayoutConstraint.activate([
            ///bannerImageView
            bannerImageView.topAnchor.constraint(equalTo: topAnchor),
            bannerImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            bannerImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            bannerImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.4),
            
            ///shadowView
            shadowView.topAnchor.constraint(equalTo: bannerImageView.topAnchor),
            shadowView.bottomAnchor.constraint(equalTo: bannerImageView.bottomAnchor),
            shadowView.leadingAnchor.constraint(equalTo: bannerImageView.leadingAnchor),
            shadowView.trailingAnchor.constraint(equalTo: bannerImageView.trailingAnchor),
            
            ///dataImageView
            dataImageView.centerYAnchor.constraint(equalTo: shadowView.bottomAnchor),
            dataImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            dataImageView.heightAnchor.constraint(equalToConstant: getScreenHeight() / 3.5),
            dataImageView.widthAnchor.constraint(equalToConstant: getScreenWidth() / 2.5),

            ///titleLabel
            titleLabel.topAnchor.constraint(equalTo: bannerImageView.bottomAnchor, constant: 10.autoSized),
            titleLabel.leadingAnchor.constraint(equalTo: dataImageView.trailingAnchor, constant: 10.autoSized),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 10.autoSized),
            
            ///yearLabel
            yearLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10.autoSized),
            yearLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            yearLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            
            ///persentageLabel
            persentageLabel.topAnchor.constraint(equalTo: yearLabel.bottomAnchor, constant: 10.autoSized),
            persentageLabel.leadingAnchor.constraint(equalTo: yearLabel.leadingAnchor),
            persentageLabel.heightAnchor.constraint(equalToConstant: 40.autoSized),
            persentageLabel.widthAnchor.constraint(equalToConstant: 40.autoSized),
            
            ///overviewTitleLabel
            overviewTitleLabel.topAnchor.constraint(equalTo: dataImageView.bottomAnchor, constant: 10.autoSized),
            overviewTitleLabel.leadingAnchor.constraint(equalTo: dataImageView.leadingAnchor),
            
            ///overviewLabel
            overviewLabel.topAnchor.constraint(equalTo: overviewTitleLabel.topAnchor),
            overviewLabel.leadingAnchor.constraint(equalTo: overviewTitleLabel.trailingAnchor, constant: 10.autoSized),
            overviewLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10.autoSized),
            
            ///budgetTitleLabel
            budgetTitleLabel.topAnchor.constraint(equalTo: overviewLabel.bottomAnchor, constant: 10.autoSized),
            budgetTitleLabel.leadingAnchor.constraint(equalTo: overviewTitleLabel.leadingAnchor),
            
            ///budgetLabel
            budgetLabel.topAnchor.constraint(equalTo: budgetTitleLabel.topAnchor),
            budgetLabel.leadingAnchor.constraint(equalTo: budgetTitleLabel.trailingAnchor, constant: 10.autoSized),
            budgetLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10.autoSized),
            
            ///revenueTitleLabel
            revenueTitleLabel.topAnchor.constraint(equalTo: budgetTitleLabel.bottomAnchor, constant: 10.autoSized),
            revenueTitleLabel.leadingAnchor.constraint(equalTo: budgetTitleLabel.leadingAnchor),
            
            ///budgetLabel
            revenueLabel.topAnchor.constraint(equalTo: revenueTitleLabel.topAnchor),
            revenueLabel.leadingAnchor.constraint(equalTo: revenueTitleLabel.trailingAnchor, constant: 10.autoSized),
            revenueLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10.autoSized),
        ])
    }
    
    //MARK: - Helper Methods
    func setData(_ movieData: MovieDetail?) {
        DispatchQueue.main.async {
            if let data = movieData {
                if let imageUrl = data.backdrop_path {
                    ImageDownloadService.getImage(urlString: AppConfiguration().bannerImageBaseURL + imageUrl) { [weak self] image in
                        self?.bannerImageView.image = image
                    }
                } else {
                    self.bannerImageView.image = UIImage(named: "Logo")
                }
                
                if let imageUrl = data.poster_path {
                    ImageDownloadService.getImage(urlString: AppConfiguration().imageBaseURL + imageUrl) { [weak self] image in
                        self?.dataImageView.image = image
                    }
                } else {
                    self.dataImageView.image = UIImage(named: "Logo")
                }
                self.titleLabel.text = data.title
                self.yearLabel.text = data.release_date
                let persentage = Int(((data.vote_average ?? 0.0) / 10.0) * 100)
                self.persentageLabel.text = "\(persentage)%"
                self.budgetLabel.text = "\(self.convertCurrency(data.budget ?? 0.0))"
                self.overviewLabel.text = data.overview
                self.revenueLabel.text = "\(self.convertCurrency(data.revenue ?? 0.0))"
            }
        }
    }
    
    //MARK: - Helper Methods
    func setPersentageLabel() {
        persentageLabel.backgroundColor = .label
        persentageLabel.clipsToBounds = true
        persentageLabel.layer.cornerRadius = 20.autoSized
        persentageLabel.layer.borderWidth = 1.autoSized
        persentageLabel.layer.borderColor = UIColor.green.cgColor
    }
    
    func convertCurrency(_ data: Double) -> String {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.numberStyle = .currency
        currencyFormatter.locale = Locale(identifier: "en_US")
        return currencyFormatter.string(from: data as NSNumber) ?? ""
    }
}
