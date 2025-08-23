import { useEffect, useState } from "react";
import Segment from "../shared/Segment";
import { createProvider } from "zebar";

const glazeWmProvider = createProvider({
    type: "glazewm",
});

export default function TilingDirection() {
    const [glazewm, setGlazeWm] = useState(glazeWmProvider.output);

    useEffect(() => {
        glazeWmProvider.onOutput(setGlazeWm);
    }, []);

    if (!glazewm) {
        return null;
    }
    return (
        <Segment onClick={() => glazewm.runCommand("toggle-tiling-direction")}>
            <div
                className={
                    glazewm.tilingDirection === "horizontal"
                        ? "nf-md-swap_horizontal"
                        : "nf-md-swap_vertical"
                }
            ></div>
        </Segment>
    );
}
