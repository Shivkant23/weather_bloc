import 'package:weather_app/features/weather/domain/entities/weather.dart';

class WeatherModel extends Weather {
  WeatherModel({
    super.windSpeed,
    super.windDegrees,
    super.temp,
    super.humidity,
    super.sunset,
    super.minTemp,
    super.cloudPct,
    super.feelsLike,
    super.sunrise,
    super.maxTemp,
  });

  WeatherModel.empty();

  WeatherModel.fromJson(Map<String, dynamic> json) {
    windSpeed = json['wind_speed'];
    windDegrees = json['wind_degrees'];
    temp = json['temp'];
    humidity = json['humidity'];
    sunset = json['sunset'];
    minTemp = json['min_temp'];
    cloudPct = json['cloud_pct'];
    feelsLike = json['feels_like'];
    sunrise = json['sunrise'];
    maxTemp = json['min_temp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['wind_speed'] = windSpeed;
    data['wind_degrees'] = windDegrees;
    data['temp'] = temp;
    data['humidity'] = humidity;
    data['sunset'] = sunset;
    data['min_temp'] = minTemp;
    data['cloud_pct'] = cloudPct;
    data['feels_like'] = feelsLike;
    data['sunrise'] = sunrise;
    data['max_temp'] = maxTemp;
    return data;
  }
}
