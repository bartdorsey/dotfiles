export function getUsageClass(usage: number) {
    if (usage > 85) {
        return "high";
    } else if (usage > 50) {
        return "medium";
    } else {
        return "low";
    }
}
