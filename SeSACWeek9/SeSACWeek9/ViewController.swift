//
//  ViewController.swift
//  SeSACWeek9
//
//  Created by 이중원 on 2022/08/30.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var lottoLabel: UILabel!
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    
    var list: Person = Person(page: 0, totalPages: 0, totalResults: 0, results: [])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        LottoAPIManager.requestLotto(drwNo: 1030) { lotto, error in
            
            guard let lotto = lotto else { return }
            self.lottoLabel.text = lotto.drwNoDate

        }
        
        PersonAPIManager.requestPerson(query: "kim") { person, error in
            guard let person = person else {
                return
            }
            dump(person)
            self.list = person
            self.tableView.reloadData()
        }
        
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        cell.textLabel?.text = list.results[indexPath.row].name
        cell.detailTextLabel?.text = list.results[indexPath.row].knownForDepartment
        return cell
    }
}

