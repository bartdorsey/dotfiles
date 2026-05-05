// PREF: enable GPU-accelerated Canvas2D [WINDOWS]
user_pref("gfx.canvas.accelerated", true);

// Disable restore window state
user_pref("browser.restoreWindowState.disabled", true);
user_pref("browser.sessionstore.resume_from_crash", false);

/****************************************************************************************
 * OPTION 3: NATURAL SMOOTH SCROLLING V3 [MODIFIED]                                     *
 ****************************************************************************************/
// recommended for 120hz+ displays
// largely matches Chrome flags: Windows Scrolling Personality and Smooth Scrolling
// from https://github.com/AveYo/fox/blob/cf56d1194f4e5958169f9cf335cd175daa48d349/Natural%20Smooth%20Scrolling%20for%20user.js
user_pref("apz.overscroll.enabled", true); // not DEFAULT on Linux
user_pref("general.smoothScroll", true); // DEFAULT
user_pref("general.smoothScroll.msdPhysics.continuousMotionMaxDeltaMS", 12);
user_pref("general.smoothScroll.msdPhysics.enabled", true);
user_pref("general.smoothScroll.msdPhysics.motionBeginSpringConstant", 600);
user_pref("general.smoothScroll.msdPhysics.regularSpringConstant", 650);
user_pref("general.smoothScroll.msdPhysics.slowdownMinDeltaMS", 25);
user_pref("general.smoothScroll.msdPhysics.slowdownMinDeltaRatio", "2");
user_pref("general.smoothScroll.msdPhysics.slowdownSpringConstant", 250);
user_pref("general.smoothScroll.currentVelocityWeighting", "1");
user_pref("general.smoothScroll.stopDecelerationWeighting", "1");
user_pref("mousewheel.default.delta_multiplier_y", 300); // 250-400; adjust this number to your liking

// My prefs
// Hardware video decoding via VA-API (NVIDIA)
user_pref("media.hardware-video-decoding.force-enabled", true);
user_pref("media.ffmpeg.vaapi.enabled", false);
user_pref("media.rdd-ffmpeg.enabled", false);
user_pref("widget.dmabuf.force-enabled", true);
user_pref("browser.warnOnQuitShortcut", false);
user_pref("layout.css.devPixelsPerPx", "1.1");
