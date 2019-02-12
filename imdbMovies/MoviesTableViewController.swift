//
//  ViewController.swift
//  imdbMovies
//
//  Created by Patrick Aloueichek on 2/11/19.
//  Copyright © 2019 Patrick Aloueichek. All rights reserved.
//

import UIKit

class MoviesTableViewController:  UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var moviesTableView: UITableView!
    
    let items = ["Item 1", "Item2", "Item3", "Item4"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       moviesTableView.register(UINib(nibName: "MoviesTableViewCell.", bundle: Bundle.main), forCellReuseIdentifier: "moviesCell")
        self.view.addSubview(moviesTableView)
     
    }

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     return  items.count
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("MoviesTableViewCell", owner: self, options: nil)?.first as! MoviesTableViewCell
        return cell
    }
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 300.0
            // the height for custom cell 0
        } else {
            return 0.0
        }
}

}
