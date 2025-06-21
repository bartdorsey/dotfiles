import styles from "./Segment.module.css";

export default function Segment({
    children,
    iconClass,
    iconText,
    onClick,
    active,
    className,
    iconAlignment,
}: {
    children: React.ReactNode;
    iconClass?: string;
    iconText?: string;
    onClick?: () => void;
    active?: boolean;
    className?: string;
    iconAlignment?: "left" | "right";
}) {
    return (
        <div
            onClick={onClick}
            className={`${styles.segment} ${
                iconAlignment ? styles[iconAlignment] : ""
            } ${className}`}
        >
            <i
                className={`${styles.icon} ${
                    iconClass ? "nf" : ""
                } ${iconClass}`}
            >
                {iconText}
            </i>
            {children ? (
                <div
                    className={`${styles.pill} ${active ? styles.active : ""} ${
                        onClick ? styles.clickable : ""
                    }`}
                >
                    {children}
                </div>
            ) : (
                ""
            )}
        </div>
    );
}
