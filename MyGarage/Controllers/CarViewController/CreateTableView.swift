//
//  CreateTableView.swift
//  MyGarage
//
//  Created by mac on 06.01.2021.
//  Copyright © 2021 mac. All rights reserved.
//

import Foundation
import UIKit

extension CarViewController: UITableViewDataSource, UITableViewDelegate {

    //MARK: UICollectionViewDataSourse

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cars.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as! CarTableViewCell
        
        var image = UIImage(named: "iconCar")
        if let imag = cars[indexPath.row].image {
            image = UIImage(data: imag)
        }
        cell.carImageView.image = image
        print(cars[indexPath.row].image ?? "image nil")
        cell.nameLabel.text = cars[indexPath.row].name
        print(cars[indexPath.row].name ?? "name nil")
        cell.subNameLabel.text = cars[indexPath.row].subName
        print(cars[indexPath.row].subName ?? "subName nil")
        cell.numberLabel.text = cars[indexPath.row].number
        print(cars[indexPath.row].number ?? "number nil")
        cell.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1).withAlphaComponent(0.2)
 
        return cell
    }

    //MARK: UICollectionViewDelegate

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {

        CoreDataManager.sharedManager.deleteCar(cars[indexPath.row])
        self.cars = CoreDataManager.sharedManager.fetchAllCars()!
        self.carsTableView!.reloadData()
    }
  
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let car = self.cars[indexPath.row]
        let dictionary = ["name": car.name, "subName": car.subName, "number": car.number]
        UserDefaults.standard.set(dictionary, forKey: "kdictionaryCar")
        UserDefaults.standard.synchronize()

        let nextVC = CarDetailViewController()
        self.navigationController?.pushViewController(nextVC, animated: true)

    }

    //MARK: Rotate Cell

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {

        let degree: Double = 90
        let rotationAngle = CGFloat(degree * Double.pi / 180)
        let rotationTransform = CATransform3DMakeRotation(rotationAngle, 1, 0, 0)
        cell.layer.transform = rotationTransform

        UIView.animate(withDuration: 1, delay: 0.2 * Double(indexPath.row), options: .curveEaseInOut, animations: {
            cell.layer.transform = CATransform3DIdentity
        }, completion: nil)

//        let translationTransform = CATransform3DTranslate(CATransform3DIdentity, -500, 400, 0)
//        cell.layer.transform = translationTransform
//        UIView.animate(withDuration: 1, delay: 0.2 * Double(indexPath.row), options: .curveEaseInOut, animations: {
//            cell.layer.transform = CATransform3DIdentity
//        }, completion: nil)
    }

//    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {

//        super.viewWillTransition(to: size, with: coordinator)
//        coordinator.animate(alongsideTransition: { (contex) in
//            self.updateLayout(with: size)
//        }, completion: nil)
//    }
}
