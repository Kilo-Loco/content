//
//  ViewController.swift
//  migrating-to-combine
//
//  Created by Kilo Loco on 10/13/20.
//

import UIKit

class AnimalsViewController: UITableViewController {

    var animals = [Animal]()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getAnimals()
    }
    
    func getAnimals() {
        NetworkingService.getAnimals { [weak self] (result) in
            switch result {
            case .success(let animals):
                self?.animals = animals
                self?.tableView.reloadData()

            case .failure(let error):
                print(error)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        animals.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AnimalCell", for: indexPath)
        
        let animalCell = cell as? AnimalCell
        let animal = animals[indexPath.row]
        animalCell?.delegate = self
        animalCell?.shouldMakeNoiseForAnimal = { [weak self] animal in
            self?.makeNoise(for: animal)
        }
        animalCell?.populate(with: animal)
        
        
        return cell
    }
    
    func showEmoji(for animal: Animal) {
        AlertService.showAlert(with: animal.emoji, in: self)
    }
    
    func makeNoise(for animal: Animal) {
        AlertService.showAlert(with: animal.noise, in: self)
    }
}

extension AnimalsViewController: AnimalCellDelegate {
    func shouldShowEmoji(for animal: Animal) {
        showEmoji(for: animal)
    }
}
