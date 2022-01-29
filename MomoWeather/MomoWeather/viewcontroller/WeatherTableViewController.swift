//
//  WeatherTableViewController.swift
//  MomoWeather
//
//  Created by momo on 2022/01/29.
//

import UIKit

class WeatherTableViewController: UITableViewController {
    
    enum Section {
        case all
    }
    
    let openWhetherClient: OpenWeatherClient = OpenWeatherClient()
    var weathersByCity: [CurrentWeatherDataResponse] = []
    lazy var dataSource: UITableViewDiffableDataSource<Section, CurrentWeatherDataResponse> = configureDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
         self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        loadInitialData()
        
        tableView.dataSource = dataSource
        var snapshot = NSDiffableDataSourceSnapshot<Section, CurrentWeatherDataResponse>()
        snapshot.appendSections([.all])
        snapshot.appendItems(weathersByCity, toSection: .all)
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    // TODO 알잘딱깔센
    func loadInitialData() {
        [
            "Seoul", "Seoul", "Seoul", "Seoul", "Seoul", "Seoul", "Seoul", "Seoul", "Seoul", "Seoul"
        ].forEach { city in
            openWhetherClient.getCurrentWeatherData(cityName: city) { result, response in
                guard result else {
                    return
                }
                self.weathersByCity.append(response)
                var currentSnapshot = self.dataSource.snapshot()
                currentSnapshot.appendItems([response], toSection: .all)
                self.dataSource.apply(currentSnapshot)
            }
        }

    }

    func configureDataSource() -> UITableViewDiffableDataSource<Section, CurrentWeatherDataResponse> {

        let cellIdentifier = "weatherTableViewCell"

        let dataSource = UITableViewDiffableDataSource<Section, CurrentWeatherDataResponse>(
            tableView: tableView,
            cellProvider: {  tableView, indexPath, openWhetherWhether in
                let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! WeatherTableViewCell
                
                //TODO
                cell.cityName.text = openWhetherWhether.name
                cell.weather.text = openWhetherWhether.weather[0].main
                cell.weatherIcon.text = openWhetherWhether.weather[0].icon
                cell.temperature.text = String(openWhetherWhether.main.temp)
                cell.humidity.text = String(openWhetherWhether.main.humidity)
                return cell
            }
        )
        return dataSource
    }
    
}
