import 'package:flutter/material.dart';

class Tab1 extends StatefulWidget {
  @override
  State<StatefulWidget> createState(){
    return _Tab1();
  }
}
class _Tab1 extends State<Tab1> {
  int _globalServiceCount = 0;
  int _setServiceCount = 0;
  int _grobalServiceGetCount = 0;
  int _setServiceGetCount = 0;
  int _globalResiveCount = 0;
  int _setResiveCount = 0;
  int _grobalResiveGetCount = 0;
  int _setResiveGetCount = 0;
  int leftPoint = 0;
  int leftPoint1 = 0;
  int leftPoint2 = 0;
  int leftPoint3 = 0;
  // int leftPoint4 = 0;
  // int leftPoint5 = 0;
  int rightPoint = 0;
  int rightPoint1 = 0;
  int rightPoint2 = 0;
  // int rightPoint3 = 0;
  // int rightPoint4 = 0;
  // int rightPoint5 = 0;
  List<int> list = [];
  List<int> leftPointlist = [];
  List<int> rightPointlist = [];

  @override
  Widget build(BuildContext context){
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children:[        
          Container(
            margin:EdgeInsets.only(top: 10),
            child:Text('$leftPoint - $rightPoint'),
          ),
          Container(
            margin:EdgeInsets.only(top: 10),
            child:Text(leftPointlist.toString()),
          ),
          Container(
            margin:EdgeInsets.only(top: 10),
            child:Text(rightPointlist.toString()),
          ),
          Container(
            child:TextButton(
              child:Text('セット終了'),
              onPressed: (){
                setState((){
                  leftPointlist.add(leftPoint);
                  rightPointlist.add(rightPoint);
                  leftPoint = 0;
                  rightPoint = 0;
                  list.clear();
                  _globalServiceCount+=_setServiceCount;
                  _globalResiveCount+=_setResiveCount;
                  _grobalServiceGetCount+=_setServiceGetCount;
                  _grobalResiveGetCount+=_setResiveGetCount;
                });
              },
            ),
          ),
          Container(
            child:Row(
              children:customButtonGet(),
            ),
          ),
          Container(
            child:Row(
              children:customButtonLost(),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child:Column(
              children:[
                Row(children:getList(1)),
                Row(children:getList(-1)),
              ],
            ),
          ),
          getServiceCount(),
          Column(
            children: getCostomData(),
          ),
          Container(
            margin:EdgeInsets.only(top:15),
            child:Text('合計サーブ回数：$_globalServiceCount'),
          ),
          Container(
            child:Text('合計サーブ得点回数：$_grobalServiceGetCount'),
          ),
          Container(
            child:Text('合計レシーブ回数：$_globalResiveCount'),
          ),
          Container(
            child:Text('合計レシーブ得点回数：$_grobalResiveGetCount'),
          ),
          Container(
            child:Text('合計サーブ得点率：'+(_grobalServiceGetCount*100/_globalServiceCount).toString()+'%',style:TextStyle(color:Colors.red)),
          ),
          Container(
            child:Text('合計レシーブ得点率：'+(_grobalResiveGetCount*100/_globalResiveCount).toString()+'%',style:TextStyle(color:Colors.red)),
          ),
        ]
      )
    );
  }
  /** 割合計算 */
  double calculatePacentage(int ch, int pe){
    return ch/pe;
  }

  /** サーブのタイミングを知るためのリスト */
  List<int> servList(){
    List<int> servList = [];
    for(int i=0;i<list.length;i++){
      if(i < 20){
        // duceになってない
        if(0==(i)%4 || (0==(i-1)%4)){
          servList.add(1);
        }else{
          servList.add(0);
        }
      } else {
        // duceになってる
        if(0==i%2){
          servList.add(1);
        }else{
          servList.add(0);
        }
      }
    }
    return servList;
  }
  /** 得点表 */
  List<Widget> getList(int num){
    List<Widget> dataList = [];
    List<int> numlist = servList();
    for(int i = 0; i<list.length; i++){
      if(num == list[i]){
        Color mc = Colors.blue;
        if(1==num){
          if(1==numlist[i]){
            mc = Colors.red;
          } else {
            mc = Colors.blue;
          }
        }
        dataList.add(
          Container(
            decoration: BoxDecoration(
              border:Border.all(color:mc),
            ),
            alignment: Alignment.center,
            height: 30,
            width: 30,
            child:Text('1'),
          )
        );
      }else{
        dataList.add(
          Container(
            decoration: BoxDecoration(
              border:Border.all(color:Colors.blue),
            ),
            height: 30,
            width: 30,
            child:Text(' '),
          )
        );
      }
    }
    return dataList;
  }
  /** 集計 */
  Widget getServiceCount(){
    List<int> numlist = servList();
    int count1 = 0;
    int countServGetPoint = 0;
    int countResiveGetPoint = 0;
    for(int num in numlist){
      if(1==num){
        count1++;
      }
    }
    for(int i = 0; i<list.length; i++){
      if(1==list[i]){
        if(1==numlist[i]){
          // サーブ得点
          countServGetPoint++;
        } else {
          // レシーブ得点
          countResiveGetPoint++;
        }
      }
    }
    int count2 = list.length - count1;
    double pacentage = countServGetPoint/count1 * 100;
    double pacentage2 = countResiveGetPoint/count2 * 100;
    _setServiceCount = count1;//クラス変数に格納
    _setResiveCount = count2;//クラス変数に格納
    _setServiceGetCount = countServGetPoint;//クラス変数に格納
    _setResiveGetCount = countResiveGetPoint;//クラス変数に格納
    return Column(
      children:[
        Container(
          child:Text('サービス回数：$count1'),
        ),
        Container(
          child:Text('レシーブ回数：$count2'),
        ),
        Container(
          child:Text('サービス時の得点回数：$countServGetPoint'),
        ),
        Container(
          child:Text('レシーブ時の得点回数：$countResiveGetPoint'),
        ),
        Container(
          child:Text('サービス得点率：$pacentage%',style:TextStyle(color:Colors.red)),
        ),
        Container(
          child:Text('レシーブ得点率：$pacentage2%',style:TextStyle(color:Colors.red)),
        ),
      ],
    );
  }
  /** 得点カスタムボタン取得 */
  List<Widget> customButtonGet(){
    List<Widget> datalist = [];
    datalist.add(
      TextButton(child: Text('攻撃で得点',style:TextStyle(backgroundColor: Colors.lightBlue,color:Colors.white)),onPressed:(){ leftPoint++;
      leftPoint1++;
      list.add(1);setState((){}); }),
    );
    datalist.add(
      TextButton(child: Text('守りで得点',style:TextStyle(backgroundColor: Colors.lightBlue,color:Colors.white)),onPressed:(){ leftPoint++;
      leftPoint2++;
      list.add(1);setState((){}); }),
    );
    datalist.add(
      TextButton(child: Text('サーブで得点',style:TextStyle(backgroundColor: Colors.lightBlue,color:Colors.white)),onPressed:(){ leftPoint++;
      leftPoint3++;
      list.add(1);setState((){}); }),
    );
    return datalist;
  }
  /** 失点カスタムボタン取得 */
  List<Widget> customButtonLost(){
    List<Widget> datalist = [];
    datalist.add(
      TextButton(child: Text('自分のミスで失点',style:TextStyle(backgroundColor: Colors.red,color:Colors.white)),onPressed:(){ rightPoint++;
      rightPoint1++;
      list.add(-1);setState((){}); }),
    );
    datalist.add(
      TextButton(child: Text('相手の攻撃で失点',style:TextStyle(backgroundColor: Colors.red,color:Colors.white)),onPressed:(){ rightPoint++;
      rightPoint2++;
      list.add(-1);setState((){}); }),
    );
    return datalist;
  }
  List<Widget> getCostomData(){
    List<Widget> datalist = [];
    datalist.add(
      Container(
        child:Text('攻撃で得点：$leftPoint1')
      )
    );
    datalist.add(
      Container(
        child:Text('守りで得点：$leftPoint2')
      )
    );
    datalist.add(
      Container(
        child:Text('サーブで得点：$leftPoint3')
      )
    );
    datalist.add(
      Container(
        child:Text('自分のミスで失点：$rightPoint1')
      )
    );
    datalist.add(
      Container(
        child:Text('相手の攻撃で失点：$rightPoint2')
      )
    );
    return datalist;
  }
}