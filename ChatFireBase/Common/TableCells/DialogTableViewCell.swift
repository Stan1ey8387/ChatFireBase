//
//  DialogTableViewCell.swift
//  ChatFireBase
//
//  Created by Захар Бабкин on 03/12/2018.
//  Copyright © 2018 Захар Бабкин. All rights reserved.
//

import UIKit

class DialogTableViewCell: UITableViewCell {
    let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 31
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraint(equalToConstant: 62).isActive = true
        
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let messageLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    fileprivate let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    fileprivate let labelsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        
        return stackView
    }()
    
    fileprivate let dateCreateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func configurate(with message: Message) {
        setupViews()
        
        photoImageView.setImage(url: URL(string: message.user?.photo ?? ""), placeholder: UIImage(named: "UserPlaceholder"))
        nameLabel.text = message.user?.name
        switch message.type {
        case .text:
            messageLabel.text = message.text
        case .image:
            messageLabel.text = "🏞"
        case .video:
            messageLabel.text = "🎬"
        case .none:
            messageLabel.text = "⁉️"
        }
        
        dateCreateLabel.text = message.dataCreate.getDate(format: "HH:mm")
    }
    
    fileprivate func setupViews() {
        mainStackView.addArrangedSubview(photoImageView)
        
        labelsStackView.addArrangedSubview(nameLabel)
        labelsStackView.addArrangedSubview(messageLabel)
        
        mainStackView.addArrangedSubview(labelsStackView)
        
        self.addSubview(mainStackView)
        
        NSLayoutConstraint.activate([
            mainStackView.leadingAnchor.constraint(lessThanOrEqualTo: self.leadingAnchor, constant: 20),
            mainStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            mainStackView.heightAnchor.constraint(equalToConstant: 62),
            mainStackView.bottomAnchor.constraint(lessThanOrEqualTo: self.bottomAnchor, constant: -5),
            ])
        
        setupDateCreateLabel()
    }
    
    fileprivate func setupDateCreateLabel() {
        addSubview(dateCreateLabel)
        
        NSLayoutConstraint.activate([
            dateCreateLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            dateCreateLabel.heightAnchor.constraint(equalToConstant: 20),
            dateCreateLabel.bottomAnchor.constraint(lessThanOrEqualTo: self.bottomAnchor, constant: -5),
            ])
    }
}
