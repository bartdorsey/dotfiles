import Network from "./segments/Network";
import Weather from "./segments/Weather";
import Cpu from "./segments/Cpu";
import Memory from "./segments/Memory";
import Media from "./segments/Media";
import Battery from "./segments/Battery";

export default function Right() {
    return (
        <div className="right">
            <Media />
            <Network />
            <Memory />
            <Cpu />
            <Battery />
            <Weather />
        </div>
    );
}
