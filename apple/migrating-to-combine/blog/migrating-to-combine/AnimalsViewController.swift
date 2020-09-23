//
//  ViewController.swift
//  migrating-to-combine
//
//  Created by Kyle Lee on 8/30/20.
//

import Combine
import UIKit

class AnimalsViewController: UITableViewController {

    var animals = [Animal]()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getAnimals()
    }
    
    var getAnimalsToken: AnyCancellable?
    func getAnimals() {
        getAnimalsToken = NetworkingService.getAnimals()
            .sink(
                receiveCompletion: { completion in
                    switch completion {
                    case .finished:
                        print("Subscription finished")
                        
                    case .failure(let error):
                        print("Error getting animals -", error)
                    }
                },
                receiveValue: { [weak self] animals in
                    self?.animals = animals
                    self?.tableView.reloadData()
                }
            )
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        animals.count
    }
    
    var cellTokens = [IndexPath: AnyCancellable]()
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AnimalCell", for: indexPath)
        
        let animalCell = cell as? AnimalCell
        let animal = animals[indexPath.row]
        animalCell?.populate(with: animal)
        
        cellTokens[indexPath] = animalCell?.actionPublisher
            .sink { [weak self] action in
                switch action {
                case .showEmoji(let animal):
                    self?.showEmoji(for: animal)
                    
                case .makeNoise(let animal):
                    self?.makeNoise(for: animal)
                }
            }
        
        return cell
    }
    
    func showEmoji(for animal: Animal) {
        AlertService.showAlert(with: animal.emoji, in: self)
    }
    
    func makeNoise(for animal: Animal) {
        AlertService.showAlert(with: animal.noise, in: self)
    }
}
