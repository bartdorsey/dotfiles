import { createProvider } from "zebar";
import { useEffect, useState } from "react";

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
        <div className="memory">
            <i className="nf nf-fae-chip"></i>
            <div className="pill">{Math.round(memory.usage)}%</div>
        </div>
    );
}
