static class Config {
  public static final boolean RECORD_VIDEO = false;

  public static float SHOW_SPEED = 10;
  public static  float HIDE_SPEED = 3;

  public static  int CELL_SIZE =  5;
  public static  float CELL_SCALE = 1.3;
  public static  float MIN_CELL_SIZE = 0.00;
  public static  float MAX_CELL_SIZE = 1.0;
  public static float COLOR_CHANGE_SPEED = 300.0;

  public static  float BORDER_WIDTH = 0;
  public static int BORDER_COLOR = 0x00FF00ff;

  public static  String cellImagePath = "data/circle_10.png";
  //public static  String cellImagePath = "data/zvezda20.png";

  public static RenderType RENDER_TYPE = RenderType.LOAD_IMAGE;
  //public static RenderType RENDER_TYPE = RenderType.GENERATE_IMAGE;
}  
