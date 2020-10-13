//
//  AnimalCell.swift
//  migrating-to-combine
//
//  Created by Kilo Loco on 10/13/20.
//

import UIKit

protocol AnimalCellDelegate: AnyObject {
    func shouldShowEmoji(for animal: Animal)
}

class AnimalCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    
    weak var delegate: AnimalCellDelegate?
    var shouldMakeNoiseForAnimal: ((Animal) -> Void)?
    
    private var animal: Animal!
    
    @IBAction func didTapShowEmojiButton() {
        delegate?.shouldShowEmoji(for: animal)
    }
    
    @IBAction func didTapMakeNoiseButton() {
        shouldMakeNoiseForAnimal?(animal)
    }
    
    func populate(with animal: Animal) {
        self.animal = animal
        nameLabel.text = animal.name
    }
}
