import 'package:flutter/material.dart';

class PointBox {
  static Widget getComponent(List<String> mypoint,List<String> yourpoint){
    return Container(
      width: 120,
      padding:EdgeInsets.only(top: 10,bottom: 10,),
      decoration: BoxDecoration(
        color:Colors.grey,
        borderRadius: BorderRadius.circular(20),
      ),
      child:Column(
        children:[
          Text( (mypoint.length > 0 ? mypoint[0] : '') +' - '+ (yourpoint.length > 0 ? yourpoint[0] : '') ),
          Text( (mypoint.length > 1 ? mypoint[1] : '') +' - '+ (yourpoint.length > 1 ? yourpoint[1] : '') ),
          Text( (mypoint.length > 2 ? mypoint[2] : '') +' - '+ (yourpoint.length > 2 ? yourpoint[2] : '') ),
          Text( (mypoint.length > 3 ? mypoint[3] : '') +' - '+ (yourpoint.length > 3 ? yourpoint[3] : '') ),
          Text( (mypoint.length > 4 ? mypoint[4] : '') +' - '+ (yourpoint.length > 4 ? yourpoint[4] : '') ),
        ],
      ),
    );
  }
}