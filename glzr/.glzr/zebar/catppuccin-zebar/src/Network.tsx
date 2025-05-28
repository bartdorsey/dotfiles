import { useEffect, useState } from "react";
import type { NetworkOutput } from "zebar";
import { createProvider } from "zebar";

const networkProvider = createProvider({
    type: "network",
    initialValue: null,
});

// Get icon to show for current network status.
function getNetworkIcon(networkOutput: NetworkOutput) {
    switch (networkOutput.defaultInterface?.type) {
        case "ethernet":
            return <i className="nf nf-md-ethernet_cable"></i>;
        case "wifi":
            if (
                networkOutput.defaultGateway?.signalStrength != null &&
                networkOutput.defaultGateway.signalStrength >= 80
            ) {
                return <i className="nf nf-md-wifi_strength_4"></i>;
            } else if (
                networkOutput.defaultGateway?.signalStrength != null &&
                networkOutput.defaultGateway.signalStrength >= 65
            ) {
                return <i className="nf nf-md-wifi_strength_3"></i>;
            } else if (
                networkOutput.defaultGateway?.signalStrength != null &&
                networkOutput.defaultGateway.signalStrength >= 40
            ) {
                return <i className="nf nf-md-wifi_strength_2"></i>;
            } else if (
                networkOutput.defaultGateway?.signalStrength != null &&
                networkOutput.defaultGateway.signalStrength >= 25
            ) {
                return <i className="nf nf-md-wifi_strength_1"></i>;
            } else {
                return <i className="nf nf-md-wifi_strength_outline"></i>;
            }
        default:
            return <i className="nf nf-md-wifi_strength_off_outline"></i>;
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
        <div className="network">
            {getNetworkIcon(network)}
            <div className="pill">
                {network.defaultInterface?.ipv4Addresses.map((ip) => {
                    return ip;
                })}
            </div>
        </div>
    );
}
