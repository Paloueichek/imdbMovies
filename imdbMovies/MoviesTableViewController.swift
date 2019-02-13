//
//  ViewController.swift
//  imdbMovies
//
//  Created by Patrick Aloueichek on 2/11/19.
//  Copyright © 2019 Patrick Aloueichek. All rights reserved.
//

import UIKit

class MoviesTableViewController:  UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var moviesTableView: UITableView!
    
   private var movies = [Movies]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        moviesTableView.register(UINib(nibName: MoviesTableViewCell.className, bundle: nil), forCellReuseIdentifier: "moviesCell")
        moviesTableView.delegate = self
        moviesTableView.dataSource = self
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     return  movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       //let cell = Bundle.main.loadNibNamed("MoviesTableViewCell", owner: self, options: nil)?.first as! MoviesTableViewCell
  
        let cell = moviesTableView.dequeueReusableCell(withIdentifier: "moviesCell") as! MoviesTableViewCell
        
        return cell
    }
}

extension NSObject {
    var className: String {
        return String(describing: type(of: self))
    }
    
    class var className: String {
        return String(describing: self)
    }
}
