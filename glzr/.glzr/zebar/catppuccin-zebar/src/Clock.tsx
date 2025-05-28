import type { DateOutput } from "zebar";

export default function Clock({ date }: { date: DateOutput | null }) {
    if (!date) {
        return null;
    }
    return (
        <>
            <i className="nf nf-seti-clock"></i>
            <div className="pill">{date.formatted}</div>
        </>
    );
}
