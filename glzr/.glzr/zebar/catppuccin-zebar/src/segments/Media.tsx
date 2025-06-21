import { useState, useEffect } from "react";
import { createProvider } from "zebar";
import Segment from "../shared/Segment";
import styles from "./Media.module.css";

const mediaProvider = createProvider({
    type: "media",
});

export default function Media() {
    const [media, setMedia] = useState(mediaProvider.output);

    useEffect(() => {
        mediaProvider.onOutput(setMedia);
    }, []);
    if (!media) {
        return null;
    }
    if (!media.currentSession) {
        return null;
    }

    function handleClick() {
        if (media?.currentSession?.isPlaying) {
            media.pause();
        } else {
            media?.play();
        }
    }

    return (
        <Segment
            className={styles.media}
            iconClass={
                media.currentSession.isPlaying ? "nf-md-pause" : "nf-md-play"
            }
            iconAlignment="right"
            onClick={handleClick}
        >
            {media.currentSession.isPlaying ? (
                <div className={styles.container}>
                    <div className={styles.title}>
                        {media.currentSession.isPlaying
                            ? media.currentSession.title
                            : ""}
                    </div>
                </div>
            ) : (
                ""
            )}
        </Segment>
    );
}
