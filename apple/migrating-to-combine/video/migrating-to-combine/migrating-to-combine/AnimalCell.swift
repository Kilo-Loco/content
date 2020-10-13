//
//  AnimalCell.swift
//  migrating-to-combine
//
//  Created by Kilo Loco on 10/13/20.
//

import Combine
import UIKit

//protocol AnimalCellDelegate: AnyObject {
//    func shouldShowEmoji(for animal: Animal)
//}

class AnimalCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    
//    weak var delegate: AnimalCellDelegate?
//    var shouldMakeNoiseForAnimal: ((Animal) -> Void)?
    
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

extension AnimalCell {
    enum Action {
        case showEmoji(Animal)
        case makeNoise(Animal)
    }
}
