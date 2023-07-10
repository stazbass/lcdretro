static class Config {
  public static final boolean RECORD_VIDEO = false;

  public static float SHOW_SPEED = 45;
  public static  float HIDE_SPEED = 40;

  public static  int CELL_SIZE = 8;
  public static  float CELL_SCALE = 1.0;
  public static  float MIN_CELL_SIZE = 0.00;
  public static  float MAX_CELL_SIZE = 2.0;
  public static float COLOR_CHANGE_SPEED = 450.0;

  public static  float BORDER_WIDTH =0;
  public static int BORDER_COLOR = 0;

  public static  String cellImagePath = "data/black_rect_32.png";
  //public static  String cellImagePath = "data/zvezda20.png";

  public static RenderType RENDER_TYPE = RenderType.LOAD_IMAGE;
  //public static RenderType RENDER_TYPE = RenderType.GENERATE_IMAGE;
  
  public static boolean WEBSOCKETS_ENABLED = false;
}  
