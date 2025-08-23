import { useState, useEffect } from "react";
import { createProvider } from "zebar";
import { getUsageClass } from "../shared/getUsageClass";
import Segment from "../shared/Segment";

const cpuProvider = createProvider({
    type: "cpu",
});

export default function Cpu() {
    const [cpu, setCpu] = useState(cpuProvider.output);

    useEffect(() => {
        cpuProvider.onOutput(setCpu);
    }, []);

    if (!cpu) {
        return null;
    }

    return (
        <Segment
            iconClass="nf-oct-cpu"
            active={false}
            className={getUsageClass(cpu.usage)}
        >
            {Math.round(cpu.usage)}%
        </Segment>
    );
}
