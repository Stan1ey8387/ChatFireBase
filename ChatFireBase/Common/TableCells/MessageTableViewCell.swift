//
//  MessageTableViewCell.swift
//  ChatFireBase
//
//  Created by Захар Бабкин on 03/12/2018.
//  Copyright © 2018 Захар Бабкин. All rights reserved.
//

import Firebase

class MessageTableViewCell: UITableViewCell {
    fileprivate let messageTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 17)
        textView.layer.masksToBounds = true
        textView.layer.cornerRadius = 5
        textView.textColor = .black
        textView.sizeToFit()
        textView.isScrollEnabled = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        
        return textView
    }()
    
    fileprivate var heightConstraint: NSLayoutConstraint?
    fileprivate var widthConstraint: NSLayoutConstraint?
    fileprivate var trailingConstraint: NSLayoutConstraint?
    fileprivate var leadingConstraint: NSLayoutConstraint?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        isUserInteractionEnabled = false
        backgroundColor = .clear
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func configurate(with message: Message) {
        messageTextView.text = message.text
        
        widthConstraint?.constant = (message.text?.width(withConstrainedHeight: frame.height, font: UIFont.systemFont(ofSize: 17)) ?? 0) + 10
        
        messageTextView.layoutSubviews()
        
        if message.fromUserId == Auth.auth().currentUser?.uid {
            messageTextView.backgroundColor = #colorLiteral(red: 0.8504745364, green: 1, blue: 0.7571207881, alpha: 1)
            messageTextView.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            messageTextView.textAlignment = .right
            trailingConstraint?.isActive = true
            leadingConstraint?.isActive = false
        } else {
            messageTextView.backgroundColor = #colorLiteral(red: 0.999904573, green: 1, blue: 0.9998808503, alpha: 1)
            messageTextView.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            messageTextView.textAlignment = .left
            
            trailingConstraint?.isActive = false
            leadingConstraint?.isActive = true
        }
    }
    
    fileprivate func setupViews() {
        addSubview(messageTextView)
        
        NSLayoutConstraint.activate([
            messageTextView.widthAnchor.constraint(lessThanOrEqualToConstant: self.frame.width - 50),
            messageTextView.topAnchor.constraint(equalTo: self.topAnchor, constant: 3),
            messageTextView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -3),
            ])
        
        widthConstraint = messageTextView.widthAnchor.constraint(equalToConstant: 0)
        widthConstraint?.priority = UILayoutPriority(rawValue: 999)
        widthConstraint?.isActive = true
        
        leadingConstraint = messageTextView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10)
        leadingConstraint?.priority = UILayoutPriority(rawValue: 999)
        
        trailingConstraint = messageTextView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10)
    }
} 
