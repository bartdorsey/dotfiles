import type { DateOutput } from "zebar";

export default function Clock({ date }: { date: DateOutput | null }) {
    if (!date) {
        return null;
    }
    return (
        <>
            <i className="nf nf-fa-calendar"></i>
            <div className="pill">{date.formatted}</div>
        </>
    );
}
