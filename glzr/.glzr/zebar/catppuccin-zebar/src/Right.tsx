import Network from "./Network";
import Weather from "./Weather";
import Cpu from "./Cpu";
import Memory from "./Memory";
import Media from "./Media";
import Battery from "./Battery";

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
