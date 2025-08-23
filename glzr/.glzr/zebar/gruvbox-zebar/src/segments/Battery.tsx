import { createProvider } from "zebar";
import { useEffect, useState } from "react";

const batteryProvider = createProvider({
    type: "battery",
});

export default function Battery() {
    const [battery, setBattery] = useState(batteryProvider.output);
    useEffect(() => {
        batteryProvider.onOutput(setBattery);
    }, []);

    if (!battery) {
        return null;
    }
    return (
        <div className="battery">
            <i className="nf nf-md-battery"></i>
            <div className="pill">
                {battery.isCharging ? "Charging" : `${battery.chargePercent}%`}
            </div>
        </div>
    );
}
