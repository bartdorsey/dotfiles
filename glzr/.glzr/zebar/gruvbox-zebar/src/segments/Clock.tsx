import type { DateOutput } from "zebar";
import Segment from "../shared/Segment";

export default function Clock({ date }: { date: DateOutput | null }) {
    if (!date) {
        return null;
    }
    return <Segment iconClass="nf-seti-clock">{date.formatted}</Segment>;
}
