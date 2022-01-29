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
        
        loadInitialData()
        
        // Uncomment the following line to preserve selection between presentations
        self.clearsSelectionOnViewWillAppear = false
        self.tableView.separatorStyle = .none
        tableView.dataSource = dataSource
    }
    
    // TODO 알잘딱깔센
    func loadInitialData() {
        [
            "Seoul", "Daejeon", "Deagu", "Jeju", "Busan", "Seoul", "Seoul", "Seoul", "Seoul", "Seoul"
        ].forEach { city in
            openWhetherClient.getCurrentWeatherData(cityName: city) { result, response in
                guard result else {
                    return
                }
                DispatchQueue.main.async {
                    self.weathersByCity.append(response)
                    var currentSnapshot = self.dataSource.snapshot()
                    currentSnapshot.appendItems([response], toSection: .all)
                    self.dataSource.apply(currentSnapshot)
                }
            }
        }
    }

    func configureDataSource() -> UITableViewDiffableDataSource<Section, CurrentWeatherDataResponse> {
        let cellIdentifier = "weatherTableViewCell"
        let dataSource = UITableViewDiffableDataSource<Section, CurrentWeatherDataResponse>(
            tableView: tableView,
            cellProvider: {  tableView, indexPath, weatherData in
                let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! WeatherTableViewCell
                cell.setWeatherData(weatherData: weatherData)
                return cell
            }
        )
        var snapshot = NSDiffableDataSourceSnapshot<Section, CurrentWeatherDataResponse>()
        snapshot.appendSections([.all])
        snapshot.appendItems(weathersByCity, toSection: .all)
        dataSource.apply(snapshot, animatingDifferences: false)
        return dataSource
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
