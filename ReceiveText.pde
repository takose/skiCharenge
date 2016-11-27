void ReceiveText(){
  float[] acc = new float[2];
  Client thisClient = myServer.available();
  if(thisClient != null){
    String message = thisClient.readString();
    if(message != null){
      myServer.write("200 OK\r");
      acc[0] = GetValue(message, "ACX:", 5);
      acc[1] = GetValue(message, "ACY:", 5);
    }
    if(acc[0] > -1000){
      float f = pow(acc[0] * -10, 3);
      if(acc[0] > 0){
        if(PosX > 0){
          PosX += Speed * f;
        }
      }
      if(acc[0] < 0){
        if(PosX < 620){
          PosX += Speed * f;
        }
      }
    }
  }
}
