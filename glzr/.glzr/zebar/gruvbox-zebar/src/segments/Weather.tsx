import type { WeatherStatus } from "zebar";
import { createProvider } from "zebar";
import { useEffect, useState } from "react";
import Segment from "../shared/Segment";
import styles from "./Weather.module.css";

const weatherProvider = createProvider({
    type: "weather",
    initialValue: null,
});

// Mapping of weather status to icon class name
const weatherIconMap: Record<WeatherStatus, string> = {
    clear_day: "nf-weather-day_sunny",
    clear_night: "nf-weather-night_clear",
    cloudy_day: "nf-weather-day_cloudy",
    cloudy_night: "nf-weather-night_alt_cloudy",
    light_rain_day: "nf-weather-day_sprinkle",
    light_rain_night: "nf-weather-night_alt_sprinkle",
    heavy_rain_day: "nf-weather-day_rain",
    heavy_rain_night: "nf-weather-night_alt_rain",
    snow_day: "nf-weather-day_snow",
    snow_night: "nf-weather-night_alt_snow",
    thunder_day: "nf-weather-day_lightning",
    thunder_night: "nf-weather-night_alt_lightning",
};

export default function Weather() {
    const [weather, setWeather] = useState(weatherProvider.output);

    useEffect(() => {
        weatherProvider.onOutput(setWeather);
    }, []);

    if (!weather) {
        return null;
    }
    return (
        <Segment
            className={styles.weather}
            iconClass={weatherIconMap[weather.status] || "nf-weather-na"}
        >
            {Math.round(weather.fahrenheitTemp)} °F
        </Segment>
    );
}
