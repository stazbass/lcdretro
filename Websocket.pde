import websockets.*;
class Websocket{
  WebsocketClient wsc;
  
  void setup(String url, PApplet parent){
    if(Config.WEBSOCKETS_ENABLED){
      wsc = new WebsocketClient(parent, "ws://localhost:8025/mind");
    }
  }
  
  void webSocketEvent(String msg) {
    if(Config.WEBSOCKETS_ENABLED){
      JSONObject message = parseJSONObject(msg);
      setMeditation(message.getInt("meditation"));
      setPoorSignal(message.getInt("poorSignal"));
      setAttention(message.getInt("attention"));
    }else{
      setMeditation(round((float)Math.random()*100.0f));
      setPoorSignal(0);
      setAttention(round((float)Math.random()*100.0f));
    }
  }
        
}
