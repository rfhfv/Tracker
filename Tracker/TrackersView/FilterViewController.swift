//
//  FilterViewController.swift
//  Tracker
//
//  Created by admin on 31.01.2024.
//

import UIKit

enum FilterName: String, CaseIterable {
    case all = "Все трекеры"
    case today = "Трекеры на сегодня"
    case completed = "Завершенные"
    case uncompleted = "Незавершенные"
}

protocol FilterViewControllerProtocol: AnyObject {
    func filterSelected(filter: FilterName)
}

// MARK: - FilterViewController

final class FilterViewController: UIViewController {
    var selectedFilter: FilterName?
    weak var delegate: FilterViewControllerProtocol?
    private let filters: [FilterName] = FilterName.allCases
    private let analyticsService = AnalyticsService()
    
    // MARK: - UiElements
    
    private lazy var filterLabel: UILabel = {
        let trackerLabel = UILabel()
        trackerLabel.text = "Фильтры"
        trackerLabel.textColor = .blackDay
        trackerLabel.font = .systemFont(ofSize: 16, weight: .medium)
        trackerLabel.translatesAutoresizingMaskIntoConstraints = false
        return trackerLabel
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.layer.cornerRadius = 16
        tableView.layer.masksToBounds = true
        tableView.isScrollEnabled = false
        tableView.backgroundColor = .whiteDay
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configViews()
        configConstraints()
        analyticsService.report(event: .open, params: ["Screen" : "FilterView"])
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        analyticsService.report(event: .close, params: ["Screen" : "FilterView"])
    }
    
    // MARK: - Private methods
    
    private func configViews() {
        view.backgroundColor = .whiteDay
        view.addSubview(filterLabel)
        view.addSubview(tableView)
    }
    
    private func configConstraints() {
        NSLayoutConstraint.activate([
            filterLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            filterLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 27),
            tableView.topAnchor.constraint(equalTo: filterLabel.bottomAnchor, constant: 38),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            tableView.heightAnchor.constraint(equalToConstant: 298)
        ])
    }
}

// MARK: - UITableViewDataSource

extension FilterViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filters.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let filter = filters[indexPath.row]
        cell.textLabel?.text = filter.rawValue
        cell.backgroundColor = .backgroundDay
        cell.accessoryType = filter == selectedFilter ? .checkmark : .none
        return cell
    }
}

// MARK: - UITableViewDelegate

extension FilterViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let previousSelectedCell = tableView.cellForRow(at: indexPath)
        previousSelectedCell?.accessoryType = .none
        let cell = tableView.cellForRow(at: indexPath)
        cell?.accessoryType = .checkmark
        tableView.deselectRow(at: indexPath, animated: true)
        let filter = filters[indexPath.row]
        delegate?.filterSelected(filter: filter)
        analyticsService.report(event: .click, params: ["Screen" : "\(filter)"])
        dismiss(animated: true)
    }
}
