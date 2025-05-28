import type { WeatherOutput } from "zebar";
import { createProvider } from "zebar";
import { useEffect, useState } from "react";

const weatherProvider = createProvider({
    type: "weather",
    initialValue: null,
});

// Get icon to show for current weather status.
function getWeatherIcon(weatherOutput: WeatherOutput) {
    switch (weatherOutput.status) {
        case "clear_day":
            return <i className="nf nf-weather-day_sunny"></i>;
        case "clear_night":
            return <i className="nf nf-weather-night_clear"></i>;
        case "cloudy_day":
            return <i className="nf nf-weather-day_cloudy"></i>;
        case "cloudy_night":
            return <i className="nf nf-weather-night_alt_cloudy"></i>;
        case "light_rain_day":
            return <i className="nf nf-weather-day_sprinkle"></i>;
        case "light_rain_night":
            return <i className="nf nf-weather-night_alt_sprinkle"></i>;
        case "heavy_rain_day":
            return <i className="nf nf-weather-day_rain"></i>;
        case "heavy_rain_night":
            return <i className="nf nf-weather-night_alt_rain"></i>;
        case "snow_day":
            return <i className="nf nf-weather-day_snow"></i>;
        case "snow_night":
            return <i className="nf nf-weather-night_alt_snow"></i>;
        case "thunder_day":
            return <i className="nf nf-weather-day_lightning"></i>;
        case "thunder_night":
            return <i className="nf nf-weather-night_alt_lightning"></i>;
    }
}

export default function Weather() {
    const [weather, setWeather] = useState(weatherProvider.output);

    useEffect(() => {
        weatherProvider.onOutput(setWeather);
    }, []);

    if (!weather) {
        return null;
    }
    return (
        <div className="weather">
            {getWeatherIcon(weather)}
            <span className="pill">
                {Math.round(weather.fahrenheitTemp)}
                °F
            </span>
        </div>
    );
}
