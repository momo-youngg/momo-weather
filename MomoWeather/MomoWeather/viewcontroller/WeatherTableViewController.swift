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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        AppUtil.lockOrientation(.portrait, andRotateTo: .portrait)
        
        navigationItem.title = "Weather"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.label]
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        AppUtil.lockOrientation(.all)
    }
    
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
        openWhetherClient.getCities()
            .forEach { city in
                openWhetherClient.getCurrentWeatherData(city: city) { result, response in
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "WeatherDetailSegue" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let destinationController = segue.destination as! WeatherDetailViewController
                destinationController.weatherData = self.weathersByCity[indexPath.row]
                destinationController.hidesBottomBarWhenPushed = true
            }
        }
    }
    
}
