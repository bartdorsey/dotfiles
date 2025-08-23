import { useEffect, useState } from "react";
import { createProvider } from "zebar";
import styles from "./Workspaces.module.css";
import Segment from "../shared/Segment";

const glazeWmProvider = createProvider({
    type: "glazewm",
});

export default function Workspaces() {
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
                    <Segment key={bindingMode.name}>
                        {bindingMode.displayName ?? bindingMode.name}
                    </Segment>
                ))}
            </>
            <div className={styles.workspaces}>
                {glazewm.currentWorkspaces.map((workspace) => (
                    <Segment
                        key={workspace.name}
                        iconText={workspace.name}
                        active={workspace.hasFocus}
                        onClick={() =>
                            glazewm.runCommand(
                                `focus --workspace ${workspace.name}`
                            )
                        }
                    >
                        {workspace.displayName ?? workspace.name}
                    </Segment>
                    // <div className="workspace">
                    //     <i>{workspace.name}</i>
                    //     <button
                    //         className={`pill ${
                    //             workspace.hasFocus && "focused"
                    //         } ${workspace.isDisplayed && "displayed"}`}
                    //         onClick={() =>
                    //             glazewm.runCommand(
                    //                 `focus --workspace ${workspace.name}`
                    //             )
                    //         }
                    //         key={workspace.name}
                    //     >
                    //         {workspace.displayName ?? workspace.name}
                    //     </button>
                    // </div>
                ))}
            </div>
        </>
    );
}
