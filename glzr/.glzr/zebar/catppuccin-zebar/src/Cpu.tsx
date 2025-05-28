import { useState, useEffect } from "react";
import { createProvider } from "zebar";

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
        <div className="cpu">
            <i className="nf nf-oct-cpu"></i>

            {/* Change the text color if the CPU usage is high. */}
            <span className={`${cpu.usage > 85 ? "high-usage" : ""} pill`}>
                {Math.round(cpu.usage)}%
            </span>
        </div>
    );
}
