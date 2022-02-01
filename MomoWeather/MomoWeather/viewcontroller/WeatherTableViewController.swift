//
//  WeatherTableViewController.swift
//  MomoWeather
//
//  Created by momo on 2022/01/29.
//

import UIKit
import CoreLocation

class WeatherTableViewController: UITableViewController, CLLocationManagerDelegate {
    
    enum Section {
        case all
    }
    
    @IBOutlet var button: UIBarButtonItem!
    
    var locationManger = CLLocationManager()
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
        self.navigationController?.navigationBar.tintColor = .label
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        AppUtil.lockOrientation(.all)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadInitialData()
        self.tableView.separatorStyle = .none
        tableView.dataSource = dataSource
        configureSortingButton()
        
        locationManger.delegate = self
        locationManger.desiredAccuracy = kCLLocationAccuracyBest
        locationManger.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManger.startUpdatingLocation()
        }
        
    }
    
    private func configureSortingButton() {
        
        func sortBy(by: (CurrentWeatherDataResponse, CurrentWeatherDataResponse) -> Bool) {
            let sorted = self.weathersByCity.sorted(by: by)
            self.weathersByCity = sorted
            var currentSnapshot = self.dataSource.snapshot()
            currentSnapshot.deleteAllItems()
            currentSnapshot.appendSections([.all])
            currentSnapshot.appendItems(sorted, toSection: .all)
            self.dataSource.apply(currentSnapshot)
        }
        
        var sortByNameToggle: Bool = false
        let sortByName = UIAction(title: "City Name",
                                  image: UIImage(systemName: "globe.asia.australia.fill")) { _ in
            sortByNameToggle = !sortByNameToggle
            sortBy {
                if (sortByNameToggle) {
                    return $0.name < $1.name
                } else {
                    return $0.name > $1.name
                }
            }
        }
        
        var sortByTempToggle: Bool = false
        let sortByTemp = UIAction(title: "Temperature",
                                  image: UIImage(systemName: "thermometer")) { _ in
            sortByTempToggle = !sortByTempToggle
            sortBy {
                if (sortByTempToggle) {
                    return $0.main.temp < $1.main.temp
                } else {
                    return $0.main.temp > $1.main.temp
                }
            }
        }
        
        var sortByLocationToggle: Bool = false
        let sortByLocation = UIAction(title: "Nearest",
                                      image: UIImage(systemName: "location.circle.fill")) { _ in
            guard let coordinate = self.locationManger.location?.coordinate else {
                let alert = UIAlertController(title: "Fail", message: "Can't get location information.", preferredStyle: .alert)
                let btnCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                alert.addAction(btnCancel)
                self.present(alert, animated: true, completion: nil)
                return
            }
            
            func getDistance(weatherCoord: OpenWeatherCoord, currentCoord: CLLocationCoordinate2D) -> CLLocationDistance {
                return CLLocation(latitude: weatherCoord.lat, longitude: weatherCoord.lon).distance(from: CLLocation(latitude: currentCoord.latitude, longitude: currentCoord.longitude))
            }
            
            sortByLocationToggle = !sortByLocationToggle
            sortBy {
                let result = getDistance(weatherCoord: $0.coord, currentCoord: coordinate) <
                getDistance(weatherCoord: $1.coord, currentCoord: coordinate)
                if (sortByLocationToggle) {
                    return result
                } else {
                    return !result
                }
            }
        }
        button.menu = UIMenu(title: "Sort By..", children: [sortByName, sortByTemp, sortByLocation])
    }
    
    private func loadInitialData() {
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
    
    private func configureDataSource() -> UITableViewDiffableDataSource<Section, CurrentWeatherDataResponse> {
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
