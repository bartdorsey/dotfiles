import React, { useState, useEffect } from "https://esm.sh/react@18?dev";
import { createRoot } from "https://esm.sh/react-dom@18/client?dev";
import * as zebar from "https://esm.sh/zebar@2";

const providers = zebar.createProviderGroup({
  network: { type: "network" },
  glazewm: { type: "glazewm" },
  cpu: { type: "cpu" },
  date: { type: "date", formatting: "EEE d MMM" },
  central: { type: "date", formatting: "t ZZZZ" },
  pacific: { type: "date", formatting: "t ZZZZ", timezone: "US/Pacific" },
  battery: { type: "battery" },
  memory: { type: "memory" },
  weather: { type: "weather" },
  media: { type: "media" },
});

createRoot(document.getElementById("root")).render(<App />);

function App() {
  const [output, setOutput] = useState(providers.outputMap);

  useEffect(() => {
    providers.onOutput(() => setOutput(providers.outputMap));
  }, []);

  // Get icon to show for current network status.
  function getNetworkIcon(networkOutput) {
    switch (networkOutput.defaultInterface?.type) {
      case "ethernet":
        return <i className="nf nf-md-ethernet_cable"></i>;
      case "wifi":
        if (networkOutput.defaultGateway?.signalStrength >= 80) {
          return <i className="nf nf-md-wifi_strength_4"></i>;
        } else if (networkOutput.defaultGateway?.signalStrength >= 65) {
          return <i className="nf nf-md-wifi_strength_3"></i>;
        } else if (networkOutput.defaultGateway?.signalStrength >= 40) {
          return <i className="nf nf-md-wifi_strength_2"></i>;
        } else if (networkOutput.defaultGateway?.signalStrength >= 25) {
          return <i className="nf nf-md-wifi_strength_1"></i>;
        } else {
          return <i className="nf nf-md-wifi_strength_outline"></i>;
        }
      default:
        return <i className="nf nf-md-wifi_strength_off_outline"></i>;
    }
  }

  // Get icon to show for current weather status.
  function getWeatherIcon(weatherOutput) {
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

  console.log(output.glazewm && output.glazewm.currentMonitor);

  return (
    <div className="app">
      <div className="left">
        <i className="nf nf-md-monitor" />
        <div className="pill">
          {output.glazewm && output.glazewm.currentMonitor.hardwareId}
        </div>
        <i className="nf nf-md-view_grid" />
        {output.glazewm && (
          <>
            {output.glazewm.bindingModes.map((bindingMode) => (
              <button className="binding-mode" key={bindingMode.name}>
                {bindingMode.displayName ?? bindingMode.name}
              </button>
            ))}

            <button
              className={`tiling-direction nf ${output.glazewm.tilingDirection === "horizontal" ? "nf-md-swap_horizontal" : "nf-md-swap_vertical"}`}
              onClick={() =>
                output.glazewm.runCommand("toggle-tiling-direction")
              }
            ></button>
          </>
        )}
        {output.glazewm && (
          <div className="workspaces">
            {output.glazewm.currentWorkspaces.map((workspace) => (
              <button
                className={`workspace pill ${workspace.hasFocus && "focused"} ${workspace.isDisplayed && "displayed"}`}
                onClick={() =>
                  output.glazewm.runCommand(
                    `focus --workspace ${workspace.name}`,
                  )
                }
                key={workspace.name}
              >
                {workspace.displayName ?? workspace.name}
              </button>
            ))}
          </div>
        )}
      </div>

      <div className="center clock">
        <i className="nf nf-seti-clock"></i>
        <div className="pill">{output.pacific?.formatted}</div>
        <i className="nf nf-fa-calendar"></i>
        <div className="pill">{output.date?.formatted}</div>
        <i className="nf nf-seti-clock"></i>
        <div className="pill">{output.central?.formatted}</div>
      </div>

      <div className="right">
        {output.media && output.media.currentSession && (
          <div className="media">
            {output.media?.currentSession.isPlaying ? (
              <div className="media-title-container pill">
                <div className="media-title">
                  {output.media?.currentSession.isPlaying
                    ? output.media.currentSession.title
                    : ""}
                </div>
              </div>
            ) : (
              ""
            )}
            {output.media?.currentSession.isPlaying ? (
              <i
                className="nf nf-md-pause"
                onClick={() => output.media.pause()}
              />
            ) : (
              <i
                className="nf nf-md-play"
                onClick={() => output.media.play()}
              />
            )}
          </div>
        )}
        {output.network && (
          <div className="network">
            {getNetworkIcon(output.network)}
            <div className="pill">
              {output.network.defaultInterface.ipv4Addresses.map((ip) => {
                return ip;
              })}
            </div>
          </div>
        )}

        {output.memory && (
          <div className="memory">
            <i className="nf nf-fae-chip"></i>
            <div className="pill">{Math.round(output.memory.usage)}%</div>
          </div>
        )}

        {output.cpu && (
          <div className="cpu">
            <i className="nf nf-oct-cpu"></i>

            {/* Change the text color if the CPU usage is high. */}
            <span
              className={`${output.cpu.usage > 85 ? "high-usage" : ""} pill`}
            >
              {Math.round(output.cpu.usage)}%
            </span>
          </div>
        )}

        {output.weather && (
          <div className="weather">
            {getWeatherIcon(output.weather)}
            <span className="pill">
              {Math.round(output.weather.fahrenheitTemp)}
              °F
            </span>
          </div>
        )}
      </div>
    </div>
  );
}
