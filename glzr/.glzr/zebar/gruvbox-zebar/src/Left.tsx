import TilingDirection from "./segments/TilingDirection";
import Workspaces from "./segments/Workspaces";

export default function Left() {
    return (
        <div className="left">
            <TilingDirection />
            <Workspaces />
        </div>
    );
}
