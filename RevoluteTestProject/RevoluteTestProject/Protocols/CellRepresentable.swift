//
//  CellRepresentable.swift
//

import UIKit

protocol CellRepresentable {
    static func registerCell(tableView: UITableView)
    func dequeueCell(tableView: UITableView, indexPath: NSIndexPath) -> UITableViewCell
    func cellSelected()
}
