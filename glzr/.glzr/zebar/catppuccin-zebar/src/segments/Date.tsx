import type { DateOutput } from "zebar";
import Segment from "../shared/Segment";

export default function Clock({ date }: { date: DateOutput | null }) {
    if (!date) {
        return null;
    }
    return <Segment iconClass="nf-fa-calendar">{date.formatted}</Segment>;
}
