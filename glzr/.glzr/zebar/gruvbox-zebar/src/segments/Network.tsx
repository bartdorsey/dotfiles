import { useEffect, useState } from "react";
import type { NetworkOutput } from "zebar";
import { createProvider } from "zebar";
import Segment from "../shared/Segment";
import styles from "./Network.module.css";

const networkProvider = createProvider({
    type: "network",
    initialValue: null,
});

// Get icon to show for current network status.
function getNetworkIcon(networkOutput: NetworkOutput): string {
    switch (networkOutput.defaultInterface?.type) {
        case "ethernet":
            return "nf-md-ethernet_cable";
        case "wifi":
            if (
                networkOutput.defaultGateway?.signalStrength != null &&
                networkOutput.defaultGateway.signalStrength >= 80
            ) {
                return "nf-md-wifi_strength_4";
            } else if (
                networkOutput.defaultGateway?.signalStrength != null &&
                networkOutput.defaultGateway.signalStrength >= 65
            ) {
                return "nf-md-wifi_strength_3";
            } else if (
                networkOutput.defaultGateway?.signalStrength != null &&
                networkOutput.defaultGateway.signalStrength >= 40
            ) {
                return "nf-md-wifi_strength_2";
            } else if (
                networkOutput.defaultGateway?.signalStrength != null &&
                networkOutput.defaultGateway.signalStrength >= 25
            ) {
                return "nf-md-wifi_strength_1";
            } else {
                return "nf-md-wifi_strength_outline";
            }
        default:
            return "nf-md-wifi_strength_off_outline";
    }
}

export default function Network() {
    const [network, setNetwork] = useState(networkProvider.output);

    useEffect(() => {
        networkProvider.onOutput(setNetwork);
    }, []);

    if (!network) {
        return null;
    }

    return (
        <Segment iconClass={getNetworkIcon(network)} className={styles.network}>
            {network.defaultInterface?.ipv4Addresses.map((ip) => {
                return ip;
            })}
        </Segment>
    );
}
