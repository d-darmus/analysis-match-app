import 'package:flutter/material.dart';

class PointHistory {
  static Widget getComponent(List<int> history){
    List<Widget> _mypointlist = [];
    List<Widget> _yourpointlist = [];
    for(int data in history){
      if(1 == data){
        _mypointlist.add(
          Container(child:Text('1'),width:25,height: 25,decoration:BoxDecoration(border:Border.all(color:Colors.grey)),alignment: Alignment.center,)
        );
        _yourpointlist.add(
          Container(child:Text('0'),width:25,height: 25,decoration:BoxDecoration(border:Border.all(color:Colors.grey)),alignment: Alignment.center,)
        );
      }else{
        _mypointlist.add(
          Container(child:Text('0'),width:25,height: 25,decoration:BoxDecoration(border:Border.all(color:Colors.grey)),alignment: Alignment.center,)
        );
        _yourpointlist.add(
          Container(child:Text('1'),width:25,height: 25,decoration:BoxDecoration(border:Border.all(color:Colors.grey)),alignment: Alignment.center,)
        );
      }
    }

    return Container(height:70 ,child:
    Column(
      children:[
        Row(children:_mypointlist),
        Row(children:_yourpointlist),
      ],
    )
    );
  }
}