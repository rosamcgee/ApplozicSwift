//
//  ALKMessageCell.swift
//  
//
//  Created by Mukesh Thawani on 04/05/17.
//  Copyright © 2017 Applozic. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher
import Applozic

// MARK: - ALKFriendMessageCell
final class ALKFriendMessageCell: ALKMessageCell {

    private var avatarImageView: UIImageView = {
        let imv = UIImageView()
        imv.contentMode = .scaleAspectFill
        imv.clipsToBounds = true
        let layer = imv.layer
        layer.cornerRadius = 18.5
        layer.masksToBounds = true
        imv.isUserInteractionEnabled = true
        return imv
    }()

    private var nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.isOpaque = true
        return label
    }()

    enum Padding {
        enum ReplyNameLabel {
            static let left: CGFloat = 0.0
            static let right: CGFloat = 0.0
            static let top: CGFloat = 10.0
        }

        enum ReplyView {
            static let height: CGFloat = 80.0
        }

        enum PreviewImageView {
            static let height: CGFloat = 50.0
            static let width: CGFloat = 70.0
            static let right: CGFloat = -57.0
            static let top: CGFloat = 10.0
            static let bottom: CGFloat = -5.0
        }
    }

    enum ConstraintIdentifier: String {
        case replyViewHeightIdentifier = "ReplyViewHeight"
        case replyNameHeightIdentifier = "ReplyNameHeight"
        case replyMessageHeightIdentifier = "ReplyMessageHeight"
        case replyPreviewImageHeightIdentifier = "ReplyPreviewImageHeight"
        case replyPreviewImageWidthIdentifier = "ReplyPreviewImageWidth"
    }

    override func setupViews() {
        super.setupViews()

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(avatarTappedAction))
        avatarImageView.addGestureRecognizer(tapGesture)

        contentView.addViewsForAutolayout(views: [avatarImageView,nameLabel])

        nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 6).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 57).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -57).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 16).isActive = true

        avatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 18).isActive = true
        avatarImageView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: 0).isActive = true

        avatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 9).isActive = true

        avatarImageView.trailingAnchor.constraint(equalTo: messageView.leadingAnchor, constant: -18).isActive = true

        avatarImageView.heightAnchor.constraint(equalToConstant: 37).isActive = true
        avatarImageView.widthAnchor.constraint(equalTo: avatarImageView.heightAnchor).isActive = true

        replyNameLabel.leadingAnchor.constraint(equalTo: replyView.leadingAnchor, constant: 5).isActive = true
        replyNameLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant:Padding.ReplyNameLabel.top).isActive = true

        //TODO:  Once reply image view is added then replyNameLabel's trailing anchor
        // will be equal to leading anchor of the imageview.

        replyNameLabel.trailingAnchor.constraint(lessThanOrEqualTo: previewImageView.leadingAnchor, constant: -10).isActive = true

        replyNameLabel.heightAnchor.constraintEqualToAnchor(constant: 0, identifier: ConstraintIdentifier.replyNameHeightIdentifier.rawValue).isActive = true

        replyMessageLabel.leadingAnchor.constraint(equalTo: replyView.leadingAnchor, constant: 5).isActive = true

        replyMessageLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant:40).isActive = true

        //TODO:  Once reply image view is added then replyNameLabel's trailing anchor
        // will be equal to leading anchor of the imageview.
        replyMessageLabel.trailingAnchor.constraint(lessThanOrEqualTo: previewImageView.leadingAnchor, constant: -10).isActive = true

        replyMessageLabel.heightAnchor.constraintEqualToAnchor(constant: 0, identifier: ConstraintIdentifier.replyMessageHeightIdentifier.rawValue).isActive = true

        previewImageView.heightAnchor.constraintEqualToAnchor(
            constant: 0,
            identifier: ConstraintIdentifier.replyMessageHeightIdentifier
                .rawValue)
            .isActive = true
        previewImageView.widthAnchor.constraintEqualToAnchor(
            constant: 0,
            identifier: ConstraintIdentifier.replyPreviewImageWidthIdentifier
                .rawValue)
            .isActive = true

        previewImageView.trailingAnchor.constraint(
            lessThanOrEqualTo: contentView.trailingAnchor,
            constant: Padding.PreviewImageView.right).isActive = true
        previewImageView.topAnchor.constraint(
            equalTo: replyView.topAnchor,
            constant: Padding.PreviewImageView.top).isActive = true
        previewImageView.bottomAnchor.constraint(
            equalTo: replyMessageLabel.bottomAnchor,
            constant: 0).isActive = true

        messageView.topAnchor.constraint(equalTo: replyView.bottomAnchor, constant: 3).isActive = true
        messageView.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -57).isActive = true

        messageView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -1 * ALKFriendMessageCell.bottomPadding()).isActive = true
        timeLabel.leadingAnchor.constraint(equalTo: messageView.trailingAnchor, constant: -35).isActive = true

        bubbleView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 3).isActive = true
        bubbleView.bottomAnchor.constraint(equalTo: messageView.bottomAnchor, constant:15).isActive = true

        bubbleView.leadingAnchor.constraint(equalTo: messageView.leadingAnchor, constant: -13).isActive = true
        bubbleView.trailingAnchor.constraint(equalTo: messageView.trailingAnchor, constant: 10).isActive = true
        bubbleView.widthAnchor.constraint(greaterThanOrEqualToConstant: 80).isActive = true

//        bubbleView.trailingAnchor.constraint(equalTo: replyNameLabel.trailingAnchor, constant: 10).isActive = true
//        bubbleView.trailingAnchor.constraint(equalTo: replyMessageLabel.trailingAnchor, constant: 10).isActive = true
        bubbleView.trailingAnchor.constraint(equalTo: previewImageView.trailingAnchor, constant: 10).isActive = true

        replyView.topAnchor.constraint(equalTo: bubbleView.topAnchor, constant: 5).isActive = true
        replyView.heightAnchor.constraintEqualToAnchor(constant: 80, identifier: ConstraintIdentifier.replyViewHeightIdentifier.rawValue).isActive = true
        replyView.leadingAnchor.constraint(equalTo: bubbleView.leadingAnchor, constant: 10).isActive = true

        replyView.trailingAnchor.constraint(equalTo: bubbleView.trailingAnchor, constant: -5).isActive = true

        timeLabel.bottomAnchor.constraint(equalTo: messageView.bottomAnchor, constant: 10).isActive = true
        
        let image = UIImage.init(named: "chat_bubble_grey", in: Bundle.applozic, compatibleWith: nil)
        bubbleView.image = image?.imageFlippedForRightToLeftLayoutDirection()
        bubbleView.tintColor =   UIColor(red: 230.0 / 255.0, green: 229.0 / 255.0, blue: 236.0 / 255.0, alpha: 1.0)

   }

    override func setupStyle() {
        super.setupStyle()

        nameLabel.setStyle(style: ALKMessageStyle.displayName)
    
        messageView.textColor = UIColor(red: 100.0 / 255.0, green: 98.0 / 255.0, blue:98.0 / 255.0, alpha: 1.0)

    }

    override func update(viewModel: ALKMessageViewModel) {
        super.update(viewModel: viewModel)
        
        if viewModel.isReplyMessage {
            replyView.constraint(withIdentifier: ConstraintIdentifier.replyViewHeightIdentifier.rawValue)?.constant = Padding.ReplyView.height
            replyNameLabel.constraint(withIdentifier: ConstraintIdentifier.replyNameHeightIdentifier.rawValue)?.constant = 30
            replyMessageLabel.constraint(withIdentifier: ConstraintIdentifier.replyMessageHeightIdentifier.rawValue)?.constant = 30
            previewImageView.constraint(withIdentifier: ConstraintIdentifier.replyMessageHeightIdentifier.rawValue)?.constant = Padding.PreviewImageView.height
            guard
                let metadata = viewModel.metadata,
                let replyId = metadata[AL_MESSAGE_REPLY_KEY] as? String,
                let actualMessage = getMessageFor(key: replyId)
                else {return}
            if actualMessage.messageType == .text || actualMessage.messageType == .html {
                previewImageView.constraint(withIdentifier: ConstraintIdentifier.replyPreviewImageWidthIdentifier.rawValue)?.constant = 0
            } else {
                previewImageView.constraint(withIdentifier: ConstraintIdentifier.replyPreviewImageWidthIdentifier.rawValue)?.constant = Padding.PreviewImageView.width
            }
        } else {
            replyView.constraint(withIdentifier: ConstraintIdentifier.replyViewHeightIdentifier.rawValue)?.constant = 0
            replyNameLabel.constraint(withIdentifier: ConstraintIdentifier.replyNameHeightIdentifier.rawValue)?.constant = 0
            replyMessageLabel.constraint(withIdentifier: ConstraintIdentifier.replyMessageHeightIdentifier.rawValue)?.constant = 0
            previewImageView.constraint(withIdentifier: ConstraintIdentifier.replyMessageHeightIdentifier.rawValue)?.constant = 0
            previewImageView.constraint(withIdentifier: ConstraintIdentifier.replyPreviewImageWidthIdentifier.rawValue)?.constant = 0
        }

        let placeHolder = UIImage(named: "placeholder", in: Bundle.applozic, compatibleWith: nil)

        if let url = viewModel.avatarURL {

            let resource = ImageResource(downloadURL: url, cacheKey: url.absoluteString)
            self.avatarImageView.kf.setImage(with: resource, placeholder: placeHolder, options: nil, progressBlock: nil, completionHandler: nil)
        } else {

            self.avatarImageView.image = placeHolder
        }

        if(viewModel.displayName != nil ){
            let  attributedString  = NSMutableAttributedString(string: viewModel.displayName!, attributes: [
                .font: UIFont(name: "Roboto-Regular", size: 12.0)!,
                .foregroundColor: UIColor(red: 100.0 / 255.0, green: 98.0 / 255.0, blue: 98.0 / 255.0, alpha: 1.0),
                .kern: 0.5
                ])
            
            self.nameLabel.attributedText = attributedString
        }
     
    }

    override class func leftPadding() -> CGFloat {
        return 64//9+37+18
    }

    override class func rightPadding() -> CGFloat {
        return 57
    }

    override class func topPadding() -> CGFloat {
        return 32//6+16+10
    }

    override class func bottomPadding() -> CGFloat {
        return 6
    }

    // MARK: - ChatMenuCell
    override func menuWillShow(_ sender: Any) {
        super.menuWillShow(sender)
        self.bubbleView.image = UIImage.init(named: "chat_bubble_grey", in: Bundle.applozic, compatibleWith: nil)
        let image = UIImage.init(named: "chat_bubble_grey", in: Bundle.applozic, compatibleWith: nil)
        bubbleView.image = image?.imageFlippedForRightToLeftLayoutDirection()
        bubbleView.tintColor =   UIColor(red: 230.0 / 255.0, green: 229.0 / 255.0, blue: 236.0 / 255.0, alpha: 1.0)

    }

    override func menuWillHide(_ sender: Any) {
        super.menuWillHide(sender)
        self.bubbleView.image = UIImage.init(named: "chat_bubble_grey", in: Bundle.applozic, compatibleWith: nil)
        let image = UIImage.init(named: "chat_bubble_grey", in: Bundle.applozic, compatibleWith: nil)
        bubbleView.image = image?.imageFlippedForRightToLeftLayoutDirection()
        bubbleView.tintColor =   UIColor(red: 230.0 / 255.0, green: 229.0 / 255.0, blue: 236.0 / 255.0, alpha: 1.0)
    }

    override class func rowHeigh(viewModel: ALKMessageViewModel,width: CGFloat) -> CGFloat {

        let minimumHeigh: CGFloat = 55.0
        let totalRowHeigh = super.rowHeigh(viewModel: viewModel, width: width)
        return totalRowHeigh < minimumHeigh ? minimumHeigh : totalRowHeigh
    }

    @objc private func avatarTappedAction() {
        avatarTapped?()
    }
}


// MARK: - ALKFriendMessageCell
final class ALKMyMessageCell: ALKMessageCell {

    fileprivate var stateView: UIImageView = {
        let sv = UIImageView()
        sv.isUserInteractionEnabled = false
        sv.contentMode = .center
        return sv
    }()

    var replyNameTrailingConstraint: NSLayoutConstraint?
    var replyMessageTrailingConstraint: NSLayoutConstraint?
    var previewMessageTrailingConstraint: NSLayoutConstraint?

    enum Padding {
        enum ReplyNameLabel {
            static let left: CGFloat = 0.0
            static let right: CGFloat = -10.0
            static let top: CGFloat = 10.0
        }

        enum ReplyView {
            static let height: CGFloat = 80.0
        }

        enum PreviewImageView {
            static let height: CGFloat = 50.0
            static let width: CGFloat = 70.0
            static let right: CGFloat = -10.0
            static let top: CGFloat = 5.0
            static let bottom: CGFloat = -5.0
        }
    }


    enum ConstraintIdentifier {
        enum ReplyNameLabel {
            static let height = "ReplyNameHeight"
        }
        enum ReplyMessageLabel {
            static let height = "ReplyMessageHeight"
        }
        enum PreviewImage {
            static let height = "ReplyPreviewImageHeight"
            static let width = "ReplyPreviewImageWidth"
        }
        static let replyViewHeightIdentifier = "ReplyViewHeight"
    }

    override func setupViews() {
        super.setupViews()

        contentView.addViewsForAutolayout(views: [stateView])

        replyNameLabel.leadingAnchor.constraint(greaterThanOrEqualTo: contentView.leadingAnchor, constant: Padding.ReplyNameLabel.left).isActive = true
        replyNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant:Padding.ReplyNameLabel.top).isActive = true

        replyNameTrailingConstraint =
            replyNameLabel.trailingAnchor.constraint(equalTo: previewImageView.leadingAnchor, constant: 0)
        replyNameTrailingConstraint?.isActive = true

        replyNameLabel.heightAnchor.constraintEqualToAnchor(constant: 0, identifier: ConstraintIdentifier.ReplyNameLabel.height).isActive = true

        replyMessageLabel.leadingAnchor.constraint(greaterThanOrEqualTo: contentView.leadingAnchor, constant: Padding.ReplyNameLabel.left).isActive = true

        replyMessageLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant:40).isActive = true

        replyMessageTrailingConstraint =
            replyMessageLabel.trailingAnchor.constraint(equalTo: previewImageView.leadingAnchor, constant: 0)
        replyMessageTrailingConstraint?.isActive = true
        replyMessageLabel.heightAnchor.constraintEqualToAnchor(constant: 0, identifier: ConstraintIdentifier.ReplyMessageLabel.height).isActive = true

        previewImageView.heightAnchor.constraintEqualToAnchor(constant: 0, identifier: ConstraintIdentifier.PreviewImage.height).isActive = true
        previewImageView.widthAnchor.constraintEqualToAnchor(constant: 0, identifier: ConstraintIdentifier.PreviewImage.width).isActive = true
        previewMessageTrailingConstraint =
            previewImageView.trailingAnchor.constraint(equalTo: replyView.trailingAnchor, constant: 0)
        previewMessageTrailingConstraint?.isActive = true

        previewImageView.trailingAnchor.constraint(
            equalTo: replyView.trailingAnchor,
            constant: Padding.PreviewImageView.right).isActive = true
        previewImageView.topAnchor.constraint(
            equalTo: replyNameLabel.topAnchor,
            constant: Padding.PreviewImageView.top).isActive = true
        previewImageView.bottomAnchor.constraint(
            equalTo: replyMessageLabel.bottomAnchor,
            constant: 0).isActive = true

        messageView.topAnchor.constraint(equalTo: replyView.bottomAnchor, constant:5).isActive = true
        messageView.leadingAnchor.constraint(greaterThanOrEqualTo: contentView.leadingAnchor, constant: ALKMessageCell.rightPadding()+30).isActive = true
        messageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -1*ALKMessageCell.leftPadding()).isActive = true
        messageView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: 1 * ALKMyMessageCell.bottomPadding()).isActive = true
     //   messageView.widthAnchor.constraint(greaterThanOrEqualToConstant: 60).isActive = true
        
        bubbleView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20).isActive = true
        bubbleView.bottomAnchor.constraint(equalTo: messageView.bottomAnchor, constant: 15).isActive = true

        bubbleView.leadingAnchor.constraint(equalTo: messageView.leadingAnchor, constant: -5).isActive = true
        bubbleView.leadingAnchor.constraint(equalTo: replyNameLabel.leadingAnchor, constant: -10).isActive = true
        bubbleView.leadingAnchor.constraint(equalTo: replyMessageLabel.leadingAnchor, constant: -10).isActive = true
        bubbleView.widthAnchor.constraint(greaterThanOrEqualToConstant: 60).isActive = true

        bubbleView.trailingAnchor.constraint(equalTo: messageView.trailingAnchor, constant: 10).isActive = true

        replyView.topAnchor.constraint(equalTo: bubbleView.topAnchor, constant: 5).isActive = true
        replyView.heightAnchor.constraintEqualToAnchor(constant: 0, identifier: ConstraintIdentifier.replyViewHeightIdentifier).isActive = true
        replyView.leadingAnchor.constraint(equalTo: bubbleView.leadingAnchor, constant: 5).isActive = true

        replyView.trailingAnchor.constraint(equalTo: bubbleView.trailingAnchor, constant: -10).isActive = true

        stateView.widthAnchor.constraint(equalToConstant: 17.0).isActive = true
        stateView.heightAnchor.constraint(equalToConstant: 9.0).isActive = true
        stateView.bottomAnchor.constraint(equalTo: bubbleView.bottomAnchor, constant: -1.0).isActive = true
        stateView.trailingAnchor.constraint(equalTo: bubbleView.trailingAnchor, constant: 13).isActive = true

        timeLabel.trailingAnchor.constraint(equalTo: messageView.trailingAnchor, constant: -2.0).isActive = true
        timeLabel.bottomAnchor.constraint(equalTo: messageView.bottomAnchor, constant: 13).isActive = true
        bringSubview(toFront: timeLabel)
        let image = UIImage.init(named: "chat_bubble_red", in: Bundle.applozic, compatibleWith: nil)
        bubbleView.image = image?.imageFlippedForRightToLeftLayoutDirection()
        bubbleView.tintColor =   UIColor(red: 92.0 / 255.0, green: 90.0 / 255.0, blue:167.0 / 255.0, alpha: 1.0)
        
    }

    override func update(viewModel: ALKMessageViewModel) {
        super.update(viewModel: viewModel)

        if viewModel.isReplyMessage {
            showReplyView()
            guard
                let metadata = viewModel.metadata,
                let replyId = metadata[AL_MESSAGE_REPLY_KEY] as? String,
                let actualMessage = getMessageFor(key: replyId)
                else {return}
            if actualMessage.messageType == .text || actualMessage.messageType == .html {
                previewImageView.constraint(withIdentifier: ConstraintIdentifier.PreviewImage.width)?.constant = 0
            } else {
                previewImageView.constraint(withIdentifier: ConstraintIdentifier.PreviewImage.width)?.constant = Padding.PreviewImageView.width
            }
        } else {
            hideReplyView()
        }

        if viewModel.isAllRead {
            stateView.image = UIImage(named: "kmreadIcon", in: Bundle.applozic, compatibleWith: nil)
        } else if viewModel.isAllReceived {
            stateView.image = UIImage(named: "kmdeliveredIcon", in: Bundle.applozic, compatibleWith: nil)
            stateView.tintColor = nil
        } else if viewModel.isSent {
            stateView.image = UIImage(named: "kmsenticon", in: Bundle.applozic, compatibleWith: nil)
            stateView.tintColor = nil
        } else {
            stateView.image = UIImage(named: "seen_state_0", in: Bundle.applozic, compatibleWith: nil)
            stateView.tintColor = UIColor.red
        }
    }

    // MARK: - ChatMenuCell
    override func menuWillShow(_ sender: Any) {
        super.menuWillShow(sender)
        self.bubbleView.image = UIImage.init(named: "chat_bubble_red", in: Bundle.applozic, compatibleWith: nil)
    }

    override func menuWillHide(_ sender: Any) {
        super.menuWillHide(sender)
        self.bubbleView.image = UIImage.init(named: "chat_bubble_red", in: Bundle.applozic, compatibleWith: nil)
    }

    fileprivate func setPreviewImageWidthToZero() {
        previewImageView.constraint(withIdentifier: ConstraintIdentifier.PreviewImage.width)?.constant = 0
    }

    fileprivate func showReplyView() {
        replyView.constraint(withIdentifier: ConstraintIdentifier.replyViewHeightIdentifier)?.constant = Padding.ReplyView.height
        replyNameLabel.constraint(withIdentifier: ConstraintIdentifier.ReplyNameLabel.height)?.constant = 30
        replyNameTrailingConstraint?.constant = Padding.ReplyNameLabel.right
        replyMessageLabel.constraint(withIdentifier: ConstraintIdentifier.ReplyMessageLabel.height)?.constant = 30
        replyMessageTrailingConstraint?.constant = Padding.ReplyNameLabel.right
        previewMessageTrailingConstraint?.constant = Padding.PreviewImageView.right
        previewImageView.constraint(withIdentifier: ConstraintIdentifier.PreviewImage.height)?.constant = Padding.PreviewImageView.height
    }

    fileprivate func hideReplyView() {
        replyView.constraint(withIdentifier: ConstraintIdentifier.replyViewHeightIdentifier)?.constant = 0
        replyNameLabel.constraint(withIdentifier: ConstraintIdentifier.ReplyNameLabel.height)?.constant = 0
        replyNameTrailingConstraint?.constant = 0
        replyMessageLabel.constraint(withIdentifier: ConstraintIdentifier.ReplyMessageLabel.height)?.constant = 0
        replyMessageTrailingConstraint?.constant = 0
        previewMessageTrailingConstraint?.constant = 0
        previewImageView.constraint(withIdentifier: ConstraintIdentifier.PreviewImage.height)?.constant = 0
        previewImageView.constraint(withIdentifier: ConstraintIdentifier.PreviewImage.width)?.constant = 0
    }
}

class ALKMessageCell: ALKChatBaseCell<ALKMessageViewModel>, ALKCopyMenuItemProtocol, ALKReplyMenuItemProtocol {

    fileprivate lazy var messageView: ALHyperLabel = {
        let label = ALHyperLabel.init(frame: .zero)
        label.textColor = UIColor(red: 255.0 / 255.0, green: 255.0 / 255.0, blue:255.0 / 255.0, alpha: 1.0)
        label.font = UIFont.init(name: "Roboto-Regular", size: 14.0)
        label.isUserInteractionEnabled = true
        label.numberOfLines = 0
        return label
    }()

    fileprivate var timeLabel: UILabel = {
        let lb = UILabel()
        lb.textColor = UIColor(red: 237.0 / 255.0, green: 230.0 / 255.0, blue: 230.0 / 255.0, alpha: 1.0)
        lb.font = UIFont.init(name: "Roboto-Regular", size: 10.0)
        lb.isOpaque = true
        return lb
    }()

    fileprivate var bubbleView: UIImageView = {
        let bv = UIImageView()
        let image = UIImage.init(named: "chat_bubble_red", in: Bundle.applozic, compatibleWith: nil)
        bv.tintColor = UIColor(netHex: 0xF1F0F0)
        bv.image = image?.imageFlippedForRightToLeftLayoutDirection()
        bv.isUserInteractionEnabled = false
        bv.isOpaque = true
        return bv
    }()

    fileprivate var replyView: UIView = {
        let view = UIView(frame: CGRect.zero)
        view.backgroundColor = UIColor.darkGray
        view.isUserInteractionEnabled = true
        return view
    }()

    fileprivate var replyNameLabel: UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.numberOfLines = 1
        return label
    }()

    fileprivate var replyMessageLabel: UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.numberOfLines = 1
        return label
    }()

    fileprivate let previewImageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect.zero)
        imageView.backgroundColor = .clear
        return imageView
    }()

    var selfNameText = "You"
    var replyViewAction: (()->())? = nil

    override func update(viewModel: ALKMessageViewModel) {
        self.viewModel = viewModel

        if viewModel.isReplyMessage {
            guard
                let metadata = viewModel.metadata,
                let replyId = metadata[AL_MESSAGE_REPLY_KEY] as? String,
                let actualMessage = getMessageFor(key: replyId)
                else {return}
            replyNameLabel.text = actualMessage.isMyMessage ?
                selfNameText:actualMessage.displayName
            replyMessageLabel.text =
                getMessageTextFrom(viewModel: actualMessage)
            if let imageURL = getURLForPreviewImage(message: actualMessage) {
                setImageFrom(url: imageURL, to: previewImageView)
            } else {
                previewImageView.image = placeholderForPreviewImage(message: actualMessage)
            }
        } else {
            replyNameLabel.text = ""
            replyMessageLabel.text = ""
            previewImageView.image = nil
        }

        self.messageView.attributedText = nil
        self.messageView.text = nil
        guard let message = viewModel.message else { return }
        var attributedMsgString = NSMutableAttributedString()

        if(viewModel.isMyMessage){
            attributedMsgString = NSMutableAttributedString(string: message, attributes: [
                .font: UIFont(name: "Roboto-Regular", size: 14.0)!,
                .foregroundColor: UIColor(red: 237.0 / 255.0, green: 230.0 / 255.0, blue:230.0 / 255.0, alpha: 1.0),
                .kern: 0.5
                ])
        }else {
            attributedMsgString = NSMutableAttributedString(string: message, attributes: [
                .font: UIFont(name: "Roboto-Regular", size: 14.0)!,
                .foregroundColor: UIColor(red: 100.0 / 255.0, green: 98.0 / 255.0, blue:98.0 / 255.0, alpha: 1.0),
                .kern: 0.5
                ])
        }
      
        if viewModel.messageType == .text {
            self.messageView.attributedText = attributedMsgString
        } else if viewModel.messageType == .html {

            let style = NSMutableParagraphStyle.init()
            style.lineBreakMode = .byWordWrapping
            style.headIndent = 0
            style.tailIndent = 0
            style.firstLineHeadIndent = 0
            style.minimumLineHeight = 17
            style.maximumLineHeight = 17

            let attributes: [NSAttributedStringKey : Any] = [NSAttributedStringKey.paragraphStyle: style]
            guard let htmlText = message.data.attributedString else { return }
            let mutableText = NSMutableAttributedString(attributedString: htmlText)
            mutableText.addAttributes(attributes, range: NSMakeRange(0,mutableText.length))
            self.messageView.attributedText = mutableText
        }
     var attributedString = NSMutableAttributedString()
        if(viewModel.isMyMessage){
            
         attributedString = NSMutableAttributedString(string: viewModel.time!, attributes: [
                .font: UIFont(name: "Roboto-Regular", size: 10.0)!,
                .foregroundColor: UIColor(red: 237.0 / 255.0, green: 230.0 / 255.0, blue: 230.0 / 255.0, alpha: 1.0),
                .kern: -0.1
                ])
        }else{
         attributedString = NSMutableAttributedString(string: viewModel.time!, attributes: [
                .font: UIFont(name: "Roboto-Regular", size: 10.0)!,
                .foregroundColor: UIColor(red: 138.0 / 255.0, green: 134.0 / 255.0, blue: 134.0 / 255.0, alpha: 1.0),
                .kern: -0.1
                ])
        }
       
        self.timeLabel.attributedText   = attributedString
        
    }

    override func setupViews() {
        super.setupViews()

        messageView.addGestureRecognizer(longPressGesture)
        contentView.addViewsForAutolayout(views: [messageView,bubbleView,replyView, replyNameLabel, replyMessageLabel,previewImageView,timeLabel])
        contentView.bringSubview(toFront: messageView)

        let replyTapGesture = UITapGestureRecognizer(target: self, action: #selector(replyViewTapped))
        replyView.addGestureRecognizer(replyTapGesture)
    }

    override func setupStyle() {
        super.setupStyle()
       // timeLabel.setStyle(style: ALKMessageStyle.time)


    }

    class func leftPadding() -> CGFloat {
        return 40
    }

    class func rightPadding() -> CGFloat {
        return 16
    }

    class func topPadding() -> CGFloat {
        return 10
    }

    class func bottomPadding() -> CGFloat {
        return 10
    }


    override class func rowHeigh(viewModel: ALKMessageViewModel,width: CGFloat) -> CGFloat {

        var messageHeigh: CGFloat = 0

        if let message = viewModel.message {


            let widthNoPadding = width - leftPadding() - rightPadding()
            let maxSize = CGSize.init(width: widthNoPadding, height: CGFloat.greatestFiniteMagnitude)

            let font = Font.normal(size: 14).font()
            let color = UIColor.color(ALKMessageStyle.message.color)

            let style = NSMutableParagraphStyle.init()
            style.lineBreakMode = .byWordWrapping
            style.headIndent = 0
            style.tailIndent = 0
            style.firstLineHeadIndent = 0
            style.minimumLineHeight = 17
            style.maximumLineHeight = 17

            let attributes: [NSAttributedStringKey : Any] = [NSAttributedStringKey.font: font,
                                              NSAttributedStringKey.foregroundColor: color,
                                              NSAttributedStringKey.paragraphStyle: style
            ]
            var size = CGRect()
            if viewModel.messageType == .html {
                guard let htmlText = message.data.attributedString else { return 30}
                let mutableText = NSMutableAttributedString(attributedString: htmlText)
                let attributes: [NSAttributedStringKey : Any] = [NSAttributedStringKey.paragraphStyle: style]
                mutableText.addAttributes(attributes, range: NSMakeRange(0,mutableText.length))
                size = mutableText.boundingRect(with: maxSize, options: [NSStringDrawingOptions.usesFontLeading, NSStringDrawingOptions.usesLineFragmentOrigin], context: nil)
            } else {
                size = message.boundingRect(with: maxSize, options: [NSStringDrawingOptions.usesFontLeading, NSStringDrawingOptions.usesLineFragmentOrigin],attributes: attributes, context: nil)
            }
            messageHeigh = ceil(size.height) + 30 // due to textview's bottom pading

            if viewModel.isReplyMessage {
                messageHeigh += 90
            }
        }

        return topPadding()+messageHeigh+bottomPadding()
    }

    func menuCopy(_ sender: Any) {
        UIPasteboard.general.string = self.viewModel?.message ?? ""
    }

    func menuReply(_ sender: Any) {
        menuAction?(.reply)
    }

    func getMessageFor(key: String) -> ALKMessageViewModel? {
        let messageService = ALMessageService()
        return messageService.getALMessage(byKey: key)?.messageModel
    }

    @objc func replyViewTapped() {
        replyViewAction?()
    }

    private func getMessageTextFrom(viewModel: ALKMessageViewModel) -> String? {
        switch viewModel.messageType {
        case .text, .html:
            return viewModel.message
        default:
            return viewModel.messageType.rawValue
        }
    }

    private func removeDefaultLongPressGestureFrom(_ textView: UITextView) {
            if let gestures = textView.gestureRecognizers {
                for ges in gestures {
                    if ges.isKind(of: UILongPressGestureRecognizer.self) {
                        ges.isEnabled = false

                    }
                    else if ges.isKind(of: UITapGestureRecognizer.self) {
                        (ges as? UITapGestureRecognizer)?.numberOfTapsRequired = 1
                    }
                }
            }
    }

    private func setImageFrom(url: URL?, to imageView: UIImageView) {
        imageView.kf.setImage(with: url)
    }

    private func getURLForPreviewImage(message: ALKMessageViewModel) -> URL? {
        switch message.messageType {
        case .photo, .video:
            return getImageURL(for: message)
        case .location:
            return getMapImageURL(for: message)
        default:
            return nil
        }
    }

    private func getImageURL(for message: ALKMessageViewModel) -> URL? {
        guard message.messageType == .photo else {return nil}
        if let filePath = message.filePath {
            let docDirPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let path = docDirPath.appendingPathComponent(filePath)
            return path
        } else if let thumnailURL = message.thumbnailURL {
            return thumnailURL
        }
        return nil
    }

    private func getMapImageURL(for message: ALKMessageViewModel) -> URL?  {
        guard message.messageType == .location else {return nil}
        guard let lat = message.geocode?.location.latitude,
            let lon = message.geocode?.location.longitude
            else { return nil }

        let latLonArgument = String(format: "%f,%f", lat, lon)
        guard let apiKey = ALUserDefaultsHandler.getGoogleMapAPIKey()
            else { return nil }
        let urlString = "https://maps.googleapis.com/maps/api/staticmap?center=\(latLonArgument)&zoom=17&size=375x295&maptype=roadmap&format=png&visual_refresh=true&markers=\(latLonArgument)&key=\(apiKey)"
        return URL(string: urlString)

    }

    private func placeholderForPreviewImage(message: ALKMessageViewModel) -> UIImage? {
        switch message.messageType {
        case .video:
            if let filepath = message.filePath {
                let docDirPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
                let path = docDirPath.appendingPathComponent(filepath)
                return getThumbnail(filePath: path)
            }
            return UIImage(named: "VIDEO", in: Bundle.applozic, compatibleWith: nil)
        case .location:
            return UIImage(named: "map_no_data", in: Bundle.applozic, compatibleWith: nil)
        default:
            return nil
        }
    }

    private func getThumbnail(filePath: URL) -> UIImage? {
        do {
            let asset = AVURLAsset(url: filePath , options: nil)
            let imgGenerator = AVAssetImageGenerator(asset: asset)
            imgGenerator.appliesPreferredTrackTransform = true
            let cgImage = try imgGenerator.copyCGImage(at: CMTimeMake(0, 1), actualTime: nil)
            return UIImage(cgImage: cgImage)

        } catch let error {
            print("*** Error generating thumbnail: \(error.localizedDescription)")
            return nil
        }
    }
}

extension ALHyperLabel {

    // To highlight when long pressed
    override open var canBecomeFirstResponder: Bool {
        return true
    }
}
