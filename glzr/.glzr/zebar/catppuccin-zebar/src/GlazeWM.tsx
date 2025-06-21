import { useEffect, useState } from "react";
import { createProvider } from "zebar";

const glazeWmProvider = createProvider({
    type: "glazewm",
});

export default function GlazeWM() {
    const [glazewm, setGlazeWm] = useState(glazeWmProvider.output);

    useEffect(() => {
        glazeWmProvider.onOutput(setGlazeWm);
    }, []);

    if (!glazewm) {
        return null;
    }

    return (
        <>
            <>
                {glazewm.bindingModes.map((bindingMode) => (
                    <button className="binding-mode" key={bindingMode.name}>
                        {bindingMode.displayName ?? bindingMode.name}
                    </button>
                ))}

                <button
                    className={`tiling-direction nf ${
                        glazewm.tilingDirection === "horizontal"
                            ? "nf-md-swap_horizontal"
                            : "nf-md-swap_vertical"
                    }`}
                    onClick={() =>
                        glazewm.runCommand("toggle-tiling-direction")
                    }
                ></button>
            </>
            <div className="workspaces">
                {glazewm.currentWorkspaces.map((workspace) => (
                    <button
                        className={`workspace pill ${
                            workspace.hasFocus && "focused"
                        } ${workspace.isDisplayed && "displayed"}`}
                        onClick={() =>
                            glazewm.runCommand(
                                `focus --workspace ${workspace.name}`
                            )
                        }
                        key={workspace.name}
                    >
                        {workspace.displayName ?? workspace.name}
                    </button>
                ))}
            </div>
        </>
    );
}
