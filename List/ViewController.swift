//
//  ViewController.swift
//  List
//
//  Created by Tejasv Singh on 9/25/25.
//

import UIKit
 
class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var timerTitle: UILabel!
    var tableView = UITableView()
    
    var timers : [TimerModel] = Array(repeating: TimerModel(), count: 40)
    var timer : Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Time Counter"
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(TimerTableView.self, forCellReuseIdentifier: "cell")
        tableView.frame = view.bounds
        view.addSubview(tableView)
        updateTimer()
    }
    
    func updateTimer(){
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(TimeCounter), userInfo: nil, repeats: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return timers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? TimerTableView else {
            return UITableViewCell()
        }
        if(timers[indexPath.row].isPaused){
            cell.backgroundColor = .darkGray
        }
        cell.configure(with: timers[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        timers[indexPath.row].isPaused = timers[indexPath.row].isPaused ? false : true
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
 
    
    @objc func TimeCounter() {
        guard let visibleIndexedRows = tableView.indexPathsForVisibleRows else { return }
        for indexPath in visibleIndexedRows {
            let timer = timers[indexPath.row]
            if !timer.isPaused {
                timers[indexPath.row].count += 1
                if let cell = tableView.cellForRow(at: indexPath) as? TimerTableView {
                    cell.configure(with: timers[indexPath.row])
                }
            }
        }
    }
}
