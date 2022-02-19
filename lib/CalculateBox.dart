import 'package:flutter/material.dart';

class CalculateBox extends StatefulWidget {
  List<int> pointlist = [];
  CalculateBox(List<int> list){
    this.pointlist = list;
  }

  @override
  State<StatefulWidget> createState(){
    return _CalculateBox(this.pointlist);
  }
}

class _CalculateBox extends State<CalculateBox> {
  List<int> pointlist = [];
  _CalculateBox(List<int> list){
    this.pointlist = list;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children:[
        Text( 'サーブ数：'+serviceCount(this.pointlist).toString() ),
        Text( 'サーブ得点率：'+scoreRateService(this.pointlist).toString()+'%' ),
        Text( 'レシーブ数：'+receiveCount(this.pointlist).toString() ),
        Text( 'レシーブ得点率：'+scoreRateReceive(this.pointlist).toString()+'%' ),
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
        if(0==(i)%4 || (0==(i-1)%4)){
          if(1 == pointlist[i]){
            // サービス時に得点している
            _tokutenInReceiveCount++;
          }
        }
      } else {
        // duceになってる
        if(0==i%2){
          if(1 == pointlist[i]){
            // サービス時に得点している
            _tokutenInReceiveCount++;
          }
        }
      }
    }
    return _tokutenInReceiveCount*100/receiveCount(pointlist);
  }
}