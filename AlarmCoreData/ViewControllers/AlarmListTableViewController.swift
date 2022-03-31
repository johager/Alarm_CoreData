//
//  AlarmListTableViewController.swift
//  AlarmCoreData
//
//  Created by James Hager on 3/31/22.
//

import UIKit

class AlarmListTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == Strings.showAlarmDetails,
              let indexPath = tableView.indexPathForSelectedRow,
              let destination = segue.destination as? AlarmDetailTableViewController
        else { return }
        
        destination.alarm = AlarmController.shared.alarms[indexPath.row]
    }
}

// MARK: - UITableViewDataSource

extension AlarmListTableViewController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AlarmController.shared.alarms.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Strings.alarmCell, for: indexPath) as? AlarmTableViewCell else { return UITableViewCell() }
        
        cell.configure(with: AlarmController.shared.alarms[indexPath.row], andDelegate: self)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        AlarmController.shared.deleteAlarm(atIndex: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
}

// MARK: - AlarmTableViewCellDelegate

extension AlarmListTableViewController: AlarmTableViewCellDelegate {
    
    func isEnabledSwitchToggled(in cell: AlarmTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        AlarmController.shared.toggleIsEnabledForAlarm(atIndex: indexPath.row)
    }
}
