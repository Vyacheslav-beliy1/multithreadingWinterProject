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
    
    @IBOutlet weak var activitiView: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    
    var images: [ImageModel] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    var imageURLs = [ "https://images.pexels.com/photos/67636/rose-blue-flower-rose-blooms-67636.jpeg?auto=compress&cs=tinysrgb&h=1500&w=1500",
                      "https://images.pexels.com/photos/36764/marguerite-daisy-beautiful-beauty.jpg?auto=compress&cs=tinysrgb&h=3200&w=3200",
                      "https://images.pexels.com/photos/1040626/pexels-photo-1040626.jpeg?auto=compress&cs=tinysrgb&h=650&w=940",
                      "https://images.pexels.com/photos/949586/pexels-photo-949586.jpeg?auto=compress&cs=tinysrgb&h=1500&w=1500",
                      "https://images.pexels.com/photos/130154/pexels-photo-130154.jpeg?auto=compress&cs=tinysrgb&h=1500&w=1500",
                      "https://images.pexels.com/photos/36770/flower-lily-lilium-candidum-madonna-lily.jpg?auto=compress&cs=tinysrgb&h=1500&w=1500"]
    // MARK: - Actions
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
//        let mySerialQueue = DispatchQueue(label: "lasdkjflkasdf")
        
        for imagePath in imageURLs {
            DispatchQueue.global(qos: .userInitiated).async {
//            mySerialQueue.async {
                let image = ImageModel(imagePath: imagePath)
                DispatchQueue.main.async {
                    self.images.append(image)
                    
                    if self.images.count >= self.imageURLs.count {
                        self.activitiView.stopAnimating()
                    }
                }
            }
        }
        
//        mySerialQueue.async {
//            DispatchQueue.main.async {
//                self.activitiView.stopAnimating()
//            }
//        }
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
