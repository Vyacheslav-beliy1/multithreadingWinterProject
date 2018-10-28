//
//  ViewController.swift
//  TableViewApp
//
//  Created by bws2007 on 10/7/18.
//  Copyright © 2018 bws2007. All rights reserved.
//

import UIKit

class ImageModel {
    private(set)var image: UIImage?
    var imagePath: String {
        didSet {
            if !imagePath.isEmpty,
                let url = URL(string: imagePath),
                let data = try? Data(contentsOf: url),
                let image = UIImage(data: data){
                self.image = image
            }
        }
    }
    
    init(imagePath:String) {
        self.imagePath = imagePath
        if !imagePath.isEmpty,
            let url = URL(string: imagePath),
            let data = try? Data(contentsOf: url),
            let image = UIImage(data: data){
            self.image = image
        }
    }
}

class ViewController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var tableView: UITableView!
    
    var imageURLs = [ "https://images.pexels.com/photos/67636/rose-blue-flower-rose-blooms-67636.jpeg?auto=compress&cs=tinysrgb&h=3200&w=3200",
                      "https://images.pexels.com/photos/36764/marguerite-daisy-beautiful-beauty.jpg?auto=compress&cs=tinysrgb&h=3200&w=3200",
                      "https://images.pexels.com/photos/1040626/pexels-photo-1040626.jpeg?auto=compress&cs=tinysrgb&h=3200&w=3200",
                      "https://images.pexels.com/photos/949586/pexels-photo-949586.jpeg?auto=compress&cs=tinysrgb&h=3200&w=3200",
                      "https://images.pexels.com/photos/130154/pexels-photo-130154.jpeg?auto=compress&cs=tinysrgb&h=3200&w=3200",
                      "https://images.pexels.com/photos/36770/flower-lily-lilium-candidum-madonna-lily.jpg?auto=compress&cs=tinysrgb&h=3200&w=3200"]
    // MARK: - Actions
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
    }
}

extension ViewController: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imageURLs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "id", for: indexPath) as! MyTableViewCell
        
        cell.imagePath = imageURLs[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}

extension ViewController: UISearchBarDelegate {
    
    func searchBarResultsListButtonClicked(_ searchBar: UISearchBar) {
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    }
}
