import { createProvider } from "zebar";
import { useEffect, useState } from "react";
import { getUsageClass } from "../shared/getUsageClass";
import Segment from "../shared/Segment";

const memoryProvider = createProvider({
    type: "memory",
});

export default function Memory() {
    const [memory, setMemory] = useState(memoryProvider.output);

    useEffect(() => {
        memoryProvider.onOutput(setMemory);
    }, []);

    if (!memory) {
        return null;
    }

    return (
        <Segment
            iconClass="nf-fae-chip"
            className={getUsageClass(memory.usage)}
        >
            {Math.round(memory.usage)}%
        </Segment>
    );
}
