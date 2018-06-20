import com.hamoid.*;
class VideoRecorder {
  VideoExport videoExport;
  boolean enabled = false;
  
  VideoRecorder(boolean enabled, VideoExport ve) {
    this.enabled = enabled;
    this.videoExport = ve;
  }

  void start() {
    if (enabled) {
      videoExport.startMovie();
    }
  }

  void frame() {
    if (enabled) {
      videoExport.saveFrame();
    }
  }
}
