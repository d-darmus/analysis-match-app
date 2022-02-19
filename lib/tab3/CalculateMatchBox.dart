import 'package:flutter/material.dart';

class CalculateMatchBox extends StatefulWidget {
  List<List<int>> pointlist = [];
  CalculateMatchBox(List<List<int>> list){
    this.pointlist = list;
  }

  @override
  State<StatefulWidget> createState(){
    return _CalculateMatchBox(this.pointlist);
  }
}

class _CalculateMatchBox extends State<CalculateMatchBox> {
  List<List<int>> pointlist = [];// 親ウィジェットからインプット
  int _radioType = 1;
  _CalculateMatchBox(List<List<int>> list){
    this.pointlist = list;
  }

  @override
  Widget build(BuildContext context) {
    String _serviceCountStr = "";
    String _receiveCountStr = "";
    String _serviceRatetStr = "";
    String _receiveRateStr = "";
    if(1==_radioType){
      int sCount = 0;
      double sRate = 0;
      int rCount = 0;
      double rRate = 0;
      for(int i = 0; i<this.pointlist.length; i++){
        if(0 == i%2){
          sCount += serviceCount(this.pointlist[i]);
          sRate += scoreRateService(this.pointlist[i]);
          rCount += receiveCount(this.pointlist[i]);
          rRate += scoreRateReceive(this.pointlist[i]);
        }else{
          sCount += receiveCount(this.pointlist[i]);
          sRate += scoreRateReceive(this.pointlist[i]);
          rCount += serviceCount(this.pointlist[i]);
          rRate += scoreRateService(this.pointlist[i]);
        }
      }
      _serviceCountStr = sCount.toString();
      _serviceRatetStr = (sRate/this.pointlist.length).toString();
      _receiveCountStr = rCount.toString();
      _receiveRateStr = (rRate/this.pointlist.length).toString();
    } else {
      int sCount = 0;
      double sRate = 0;
      int rCount = 0;
      double rRate = 0;
      for(int i = 0; i<this.pointlist.length; i++){
        if(0 == i%2){
          sCount += receiveCount(this.pointlist[i]);
          sRate += scoreRateReceive(this.pointlist[i]);
          rCount += serviceCount(this.pointlist[i]);
          rRate += scoreRateService(this.pointlist[i]);
        }else{
          sCount += serviceCount(this.pointlist[i]);
          sRate += scoreRateService(this.pointlist[i]);
          rCount += receiveCount(this.pointlist[i]);
          rRate += scoreRateReceive(this.pointlist[i]);
        }
      }
      _serviceCountStr = sCount.toString();
      _serviceRatetStr = (sRate/this.pointlist.length).toString();
      _receiveCountStr = rCount.toString();
      _receiveRateStr = (rRate/this.pointlist.length).toString();
    }

    return Column(
      children:[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
            Text('試合開始時サーブ権：'),
            Radio(
              activeColor:Colors.blue,
              value: 1,
              groupValue: _radioType,
              onChanged:(value){setState((){_radioType = 1;});},
            ),
            Text('自分'),
            Radio(
              activeColor:Colors.blue,
              value: -1,
              groupValue: _radioType,
              onChanged:(value){setState((){_radioType = -1;});},
            ),
            Text('相手'),
          ],
        ),
        Text( '総サーブ数：'+_serviceCountStr),
        Text( '総サーブ得点率：'+_serviceRatetStr+'%' ),
        Text( '総レシーブ数：'+_receiveCountStr ),
        Text( '総レシーブ得点率：'+_receiveRateStr+'%' ),
      ],
    );
  }

  /** サービス数取得 */
  static int serviceCount(List<int> pointlist){
    int _serviceCount = 0;
    for(int i=0;i<pointlist.length;i++){
      if(i < 20){
        // duceになってない
        if(0==(i)%4 || (0==(i-1)%4)){
          _serviceCount++;
        }
      } else {
        // duceになってる
        if(0==i%2){
          _serviceCount++;
        }
      }
    }
    return _serviceCount;
  }
  /** レシーブ数取得 */
  static int receiveCount(List<int> pointlist){
    int _receiveCount = 0;
    for(int i=0;i<pointlist.length;i++){
      if(i < 20){
        // duceになってない
        if( !(0==(i)%4 || (0==(i-1)%4)) ){
          _receiveCount++;
        }
      } else {
        // duceになってる
        if( !(0==i%2) ){
          _receiveCount++;
        }
      }
    }
    return _receiveCount++;
  }
  /** 
   * サービス得点率取得 
   * @param 得点リスト
   * */
   static double scoreRateService(List<int> pointlist){
    int _tokutenInServiceCount = 0;
    for(int i=0;i<pointlist.length;i++){
      if(i < 20){
        // duceになってない
        if(0==(i)%4 || (0==(i-1)%4)){
          if(1 == pointlist[i]){
            // サービス時に得点している
            _tokutenInServiceCount++;
          }
        }
      } else {
        // duceになってる
        if(0==i%2){
          if(1 == pointlist[i]){
            // サービス時に得点している
            _tokutenInServiceCount++;
          }
        }
      }
    }
    return _tokutenInServiceCount*100/serviceCount(pointlist);
  }
  /** 
   * レシーブ得点率取得 
   * @param 得点リスト
   * */
   static double scoreRateReceive(List<int> pointlist){
    int _tokutenInReceiveCount = 0;
    for(int i=0;i<pointlist.length;i++){
      if(i < 20){
        // duceになってない
        if( !(0==(i)%4 || (0==(i-1)%4)) ){
          if(1 == pointlist[i]){
            _tokutenInReceiveCount++;
          }
        }
      } else {
        // duceになってる
        if( !(0==i%2) ){
          if(1 == pointlist[i]){
            _tokutenInReceiveCount++;
          }
        }
      }
    }
    return _tokutenInReceiveCount*100/receiveCount(pointlist);
  }
}