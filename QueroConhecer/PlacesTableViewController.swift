//
//  PlacesTableViewController.swift
//  QueroConhecer
//
//  Created by Gabriel Carvalho Guerrero on 20/03/19.
//  Copyright © 2019 Gabriel Carvalho Guerrero. All rights reserved.
//

import UIKit

class PlacesTableViewController: UITableViewController {
    
    var places: [Place] = []
    let userDefaults = UserDefaults.standard
    var labelNoPlaces: UILabel!
    
    func loadPlaces() {
        if let placesData = userDefaults.data(forKey: "places") {
            do {
                places = try JSONDecoder().decode([Place].self, from: placesData)
                tableView.reloadData()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func savePlaces() {
        let json = try? JSONEncoder().encode(places)
        userDefaults.set(json, forKey: "places")
    }
    
    @objc func showAll() {
        performSegue(withIdentifier: "mapSegue", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadPlaces()
        
        labelNoPlaces = UILabel()
        labelNoPlaces.text = "Cadastre os locais que deseha conhecer \nclicando no botão '+'acima"
        labelNoPlaces.textAlignment = .center
        labelNoPlaces.numberOfLines = 0
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if places.count > 0 {
            let buttonShowAll = UIBarButtonItem(title: "Mostrar todos no mapa", style: .plain, target: self, action: #selector(showAll))
            navigationItem.leftBarButtonItem = buttonShowAll
            tableView.backgroundView = nil
        } else {
            navigationItem.leftBarButtonItem = nil
            tableView.backgroundView = labelNoPlaces
        }
        
        return places.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        let place = places[indexPath.row]
        cell.textLabel?.text = place.name

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let place = places[indexPath.row]
        performSegue(withIdentifier: "mapSegue", sender: place)
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            places.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            savePlaces()
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier! != "mapSegue" {
            let vc = segue.destination as! PlaceFinderViewController
            vc.delegate = self
        } else {
            let vc = segue.destination as! MapViewController
            
            switch sender {
            case let place as Place:
                vc.places = [place]
            default:
                vc.places = places
            }
        }
    }

}

extension PlacesTableViewController: PlaceFinderDelegate {
    func addPlace(_ place: Place) {
        if !places.contains(place) {
            places.append(place)
            savePlaces()
            tableView.reloadData()
        }
    }
}
