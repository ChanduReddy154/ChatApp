//
//  ChatViewController.swift
//  ChatApplication
//
//  Created by Chandu Reddy on 23/09/20.
//  Copyright © 2020 Chandu Reddy. All rights reserved.
//

import UIKit
import MessageKit

struct Message : MessageType {
    var sender: SenderType
    var messageId: String
    var sentDate: Date
    var kind: MessageKind
}

struct Sender : SenderType {
    var photoURL : String
    var senderId: String
    var displayName: String
}

var messages = [Message]()
let messageSender = Sender(photoURL: "", senderId: "1", displayName: "Chandu reddy")

class ChatViewController: MessagesViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        messages.append(Message(sender: messageSender, messageId: "1", sentDate: Date(), kind: .text("Hello")))
        messages.append(Message(sender: messageSender, messageId: "2", sentDate: Date(), kind: .text("How are you")))
        messages.append(Message(sender: messageSender, messageId: "3", sentDate: Date(), kind: .text("Bitch")))
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesDisplayDelegate = self
        messagesCollectionView.messagesLayoutDelegate = self
    }
    
}

extension ChatViewController : MessagesDisplayDelegate, MessagesDataSource, MessagesLayoutDelegate {
    func currentSender() -> SenderType {
        return messageSender
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        return messages[indexPath.section]
    }
    
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        return messages.count
    }
    
    
}
