//
//  MessageImageTableViewCell.swift
//  ChatFireBase
//
//  Created by Захар Бабкин on 06/12/2018.
//  Copyright © 2018 Захар Бабкин. All rights reserved.
//

import Firebase
import Hero

protocol MessageImageTableViewCellDelegate: class {
    func selected(image: Data)
}

class MessageImageTableViewCell: UITableViewCell {
    public weak var delegate: MessageImageTableViewCellDelegate?
    
    let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .green
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.hero.modifiers = [HeroModifier.zPosition(-1)]
        
        return imageView
    }()
    
    fileprivate var heightConstraint: NSLayoutConstraint?
    fileprivate var trailingConstraint: NSLayoutConstraint?
    fileprivate var leadingConstraint: NSLayoutConstraint?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = .clear
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func configurate(with message: Message) {
        photoImageView.setImage(url: URL(string: message.image?.image ?? ""), placeholder:  UIImage(named: "ImagePlaceholder"))
        heightConstraint?.constant = (UIScreen.main.bounds.width / 2) * CGFloat(message.image?.height ?? 0) / CGFloat(message.image?.width ?? 0)
        
        if message.fromUserId == Auth.auth().currentUser?.uid {
            photoImageView.backgroundColor = #colorLiteral(red: 0.8504745364, green: 1, blue: 0.7571207881, alpha: 1)
            trailingConstraint?.isActive = true
            leadingConstraint?.isActive = false
        } else {
            photoImageView.backgroundColor = #colorLiteral(red: 0.999904573, green: 1, blue: 0.9998808503, alpha: 1)
            trailingConstraint?.isActive = false
            leadingConstraint?.isActive = true
        }
    }
    
    private func setupViews() {
        addSubview(photoImageView)
        
        photoImageView.isUserInteractionEnabled = true
        photoImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(touchOnImage)))
        
        NSLayoutConstraint.activate([
            photoImageView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 2),
            photoImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 3),
            photoImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -3),
            ])
        
        heightConstraint = photoImageView.heightAnchor.constraint(equalToConstant: 0)
        heightConstraint?.priority = UILayoutPriority(rawValue: 999)
        heightConstraint?.isActive = true
        
        leadingConstraint = photoImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10)
        leadingConstraint?.priority = UILayoutPriority(rawValue: 999)
        
        trailingConstraint = photoImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10)
    }
    
    // Selectors
    
    @objc fileprivate func touchOnImage() {
        guard let image = photoImageView.image?.jpegData(compressionQuality: 1) else { return }
        photoImageView.hero.id = "\(image.count)"
        delegate?.selected(image: image)
    }
}
