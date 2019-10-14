static class Config{
  public static final boolean RECORD_VIDEO = false;
  
  public static float SHOW_SPEED =1;
  public static  float HIDE_SPEED = 2;
  
  public static  int CELL_SIZE = 30;
  public static  float CELL_SCALE = 0.7;
  public static  float MIN_CELL_SIZE = 0.00;
  public static  float MAX_CELL_SIZE = 1.0;
  public static float COLOR_CHANGE_SPEED = 10.0;
  
  public static  float BORDER_WIDTH =2.1;
  public static int BORDER_COLOR = 0x00FF00ff;
  
  public static  String cellImagePath = "data/rect_round.png";
  
  //public static RenderType RENDER_TYPE = RenderType.LOAD_IMAGE;
  public static RenderType RENDER_TYPE = RenderType.GENERATE_IMAGE;
}  
