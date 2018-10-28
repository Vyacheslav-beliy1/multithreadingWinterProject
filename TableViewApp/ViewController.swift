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
    
    var images: [ImageModel] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
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
        return images.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "id", for: indexPath) as! MyTableViewCell
        
        cell.myImageView.image = images[indexPath.row].image
        
        return cell
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBarResultsListButtonClicked(_ searchBar: UISearchBar) {
        
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text {
            let image = ImageModel(imagePath: text)
            images.append(image)
        }
    }
}
