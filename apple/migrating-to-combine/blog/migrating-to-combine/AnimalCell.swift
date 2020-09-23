//
//  AnimalCell.swift
//  migrating-to-combine
//
//  Created by Kyle Lee on 8/30/20.
//

import Combine
import UIKit

class AnimalCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    
    enum Action {
        case showEmoji(Animal)
        case makeNoise(Animal)
    }
    
    var actionPublisher = PassthroughSubject<Action, Never>()
    
    private var animal: Animal!
    
    @IBAction func didTapShowEmojiButton() {
        actionPublisher.send(.showEmoji(animal))
    }
    
    @IBAction func didTapMakeNoiseButton() {
        actionPublisher.send(.makeNoise(animal))
    }
    
    func populate(with animal: Animal) {
        self.animal = animal
        nameLabel.text = animal.name
    }
}
