import { useEffect, useState } from "react";
import Clock from "./Clock";
import Date from "./Date";
import { createProvider } from "zebar";

const pacificProvider = createProvider({
    type: "date",
    formatting: "t ZZZZ",
    timezone: "US/Pacific",
});

const centralProvider = createProvider({
    type: "date",
    formatting: "t ZZZZ",
});
const dateProvider = createProvider({
    type: "date",
    formatting: "EEE d MMM yyyy",
});

export default function Center() {
    const [pacific, setPacific] = useState(pacificProvider.output);
    const [central, setCentral] = useState(centralProvider.output);
    const [date, setDate] = useState(dateProvider.output);

    useEffect(() => {
        pacificProvider.onOutput(setPacific);
        centralProvider.onOutput(setCentral);
        dateProvider.onOutput(setDate);
    }, []);

    return (
        <div className="center clock">
            <Clock date={pacific} />
            <Date date={date} />
            <Clock date={central} />
        </div>
    );
}
