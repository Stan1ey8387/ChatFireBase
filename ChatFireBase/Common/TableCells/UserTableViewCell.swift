//
//  UserTableViewCell.swift
//  ChatFireBase
//
//  Created by Захар Бабкин on 29/11/2018.
//  Copyright © 2018 Захар Бабкин. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {
    
    let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 20
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let emailLabel: UILabel = {
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

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func configurate(with user: User) {
        setupViews()
        photoImageView.setImage(url: URL(string: user.photo ?? ""), placeholder: UIImage(named: "UserPlaceholder"))
        nameLabel.text = user.name
        emailLabel.text = user.email
    }
    
    fileprivate func setupViews() {
        mainStackView.addArrangedSubview(photoImageView)
        
        labelsStackView.addArrangedSubview(nameLabel)
        labelsStackView.addArrangedSubview(emailLabel)
        
        mainStackView.addArrangedSubview(labelsStackView)
        
        self.addSubview(mainStackView)
        
        NSLayoutConstraint.activate([
            mainStackView.leadingAnchor.constraint(lessThanOrEqualTo: self.leadingAnchor, constant: 10),
            mainStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            mainStackView.heightAnchor.constraint(equalToConstant: 40),
            mainStackView.bottomAnchor.constraint(lessThanOrEqualTo: self.bottomAnchor, constant: -5),
            ])
    }
}
