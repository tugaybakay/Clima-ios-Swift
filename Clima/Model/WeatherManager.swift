import Foundation
import CoreLocation

protocol WeatherManagerDelegate{
    func didUpdateWeather(weather: WeatherModel)
}

struct WeatherManager{
    var delegate: WeatherManagerDelegate?
    
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid={YOUR_API_KEY}&units=metric"
    
    func fecthWeather(cityName: String){
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(urlString)
    }
    
    func fecthWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees){
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        performRequest(urlString)
    }
    
    func performRequest(_ urlString: String){
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { (data, response, error) in
                if error == nil {
                    if let safeData = data {
                        if let weather = self.parseJSON(data: safeData){
                            delegate?.didUpdateWeather(weather: weather)
                        }
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(data: Data) -> WeatherModel?{
        let decoder = JSONDecoder()
        do{
            let weatherData = try decoder.decode(WeatherData.self, from: data)
            let weatherModel = WeatherModel(id: weatherData.weather[0].id, temp: weatherData.main.temp, name: weatherData.name)
            return weatherModel
        }catch{
            print("error!")
            return nil
        }
    }
}
