import { useState, useEffect } from "react";
import { createProvider } from "zebar";
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
    return (
        <div className="media">
            {media.currentSession.isPlaying ? (
                <div className="media-title-container pill">
                    <div className="media-title">
                        {media.currentSession.isPlaying
                            ? media.currentSession.title
                            : ""}
                    </div>
                </div>
            ) : (
                ""
            )}
            {media.currentSession.isPlaying ? (
                <i className="nf nf-md-pause" onClick={() => media.pause()} />
            ) : (
                <i className="nf nf-md-play" onClick={() => media.play()} />
            )}
        </div>
    );
}
