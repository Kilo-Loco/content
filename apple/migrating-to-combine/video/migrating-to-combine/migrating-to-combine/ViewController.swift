//
//  ViewController.swift
//  migrating-to-combine
//
//  Created by Kilo Loco on 10/13/20.
//

import Combine
import UIKit

class AnimalsViewController: UITableViewController {

    var animals = [Animal]()
    
    var tokens = Set<AnyCancellable>()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getAnimals()
    }
    
    var getAnimalsToken: AnyCancellable?
    func getAnimals() {
        getAnimalsToken = NetworkingService.getAnimals()
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { (completion) in
                    switch completion {
                    case .finished:
                        print("Publisher stopped observing")
                        
                    case .failure(let error):
                        print("This is any error passed to our future", error)
                    }
                },
                receiveValue: { [weak self] (animals) in
                    self?.animals = animals
                    self?.tableView.reloadData()
                }
            )

        
//        NetworkingService.getAnimals { [weak self] (result) in
//            switch result {
//            case .success(let animals):
//                self?.animals = animals
//                self?.tableView.reloadData()
//
//            case .failure(let error):
//                print(error)
//            }
//        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        animals.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AnimalCell", for: indexPath)
        
        let animalCell = cell as? AnimalCell
        let animal = animals[indexPath.row]
        
        animalCell?.actionPublisher.sink(receiveValue: { [weak self] action in
            switch action {
            case .showEmoji(let animal):
                self?.showEmoji(for: animal)
                
            case .makeNoise(let animal):
                self?.makeNoise(for: animal)
            }
        }).store(in: &tokens)
        
//        animalCell?.delegate = self
//        animalCell?.shouldMakeNoiseForAnimal = { [weak self] animal in
//            self?.makeNoise(for: animal)
//        }
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
//
//extension AnimalsViewController: AnimalCellDelegate {
//    func shouldShowEmoji(for animal: Animal) {
//        showEmoji(for: animal)
//    }
//}
