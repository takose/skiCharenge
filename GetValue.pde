float GetValue(String buf, String Query, int len){
  float val;
  int Qlen = Query.length();
  if(buf.indexOf(Query)>=0 && (buf.indexOf(Query)+Qlen+len) < buf.length()){
    val = Float.parseFloat(buf.substring(
                            buf.indexOf(Query)+Qlen,
                            buf.indexOf(Query)+Qlen+len));
    return val;
  }else {
    return -1000;
  }
}
