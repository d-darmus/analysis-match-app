
import 'package:dev_analysis/db/Setting.dart';
import 'package:flutter/material.dart';
import 'package:dev_analysis/tab3/pointBox.dart';
import 'package:dev_analysis/tab3/PointHistory.dart';
import 'package:dev_analysis/CalculateBox.dart';
import 'dart:convert';

class Tab3 extends StatefulWidget {
  @override
  State<StatefulWidget> createState(){
    return _Tab3();
  }
}
class _Tab3 extends State<Tab3> {
  List<String> mypoint = ['0'];
  List<String> yourpoint = ['0'];
  List<int> _pointlist = [];
  List<int> customCount1 = [0,0,0,0];
  List<int> customCount2 = [0,0,0,0];
  List<String> customButton1 = ['button1','button2','button3','button4'];
  List<String> customButton2 = ['button1','button2','button3','button4'];
  @override
  void initState(){
    customInitialized();
    super.initState();
  }

  void customInitialized() async{
    List<Setting> settinglist = await Setting.getDatas();
    if(settinglist.length > 0){
      dynamic json1 = jsonDecode(settinglist[0].custom1);
      dynamic json2 = jsonDecode(settinglist[0].custom2);
      for(int i = 0; i<json1.length; i++){
        setState((){
          this.customButton1[i] = json1[i];
        });
      }
      for(int i = 0; i<json2.length; i++){
        setState((){
          this.customButton2[i] = json2[i];
        });
      }
    }
  }

  @override
  Widget build(BuildContext context){

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children:[
          PointBox.getComponent(mypoint,yourpoint),
          settingButton(),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: PointHistory.getComponent(this._pointlist),
          ),
          _getButtonsComponent(),
          CalculateBox(this._pointlist),
          Text(this.customButton1[0]+'回数：'+this.customCount1[0].toString(),style:TextStyle(color:Colors.blue)),
          Text(this.customButton1[1]+'回数：'+this.customCount1[1].toString(),style:TextStyle(color:Colors.blue)),
          Text(this.customButton1[2]+'回数：'+this.customCount1[2].toString(),style:TextStyle(color:Colors.blue)),
          Text(this.customButton1[3]+'回数：'+this.customCount1[3].toString(),style:TextStyle(color:Colors.blue)),
          Text(this.customButton2[0]+'回数：'+this.customCount2[0].toString(),style:TextStyle(color:Colors.red)),
          Text(this.customButton2[1]+'回数：'+this.customCount2[1].toString(),style:TextStyle(color:Colors.red)),
          Text(this.customButton2[2]+'回数：'+this.customCount2[2].toString(),style:TextStyle(color:Colors.red)),
          Text(this.customButton2[3]+'回数：'+this.customCount2[3].toString(),style:TextStyle(color:Colors.red)),
        ],
      )
    );
  }
  
  /** データ更新 */
  void _updateFiled(){
    int _mypoint = 0;
    int _yourpoint = 0;
    for(int data in this._pointlist){
      if(1 == data){
        _mypoint++;
      }else{
        _yourpoint++;
      }
    }
    this.mypoint[this.mypoint.length-1] = _mypoint.toString();
    this.yourpoint[this.yourpoint.length-1] = _yourpoint.toString();
  }

  /** ボタンコンポーネント */
  Widget _getButtonsComponent(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children:[
        Column(
          children:[
            Container(
              margin:EdgeInsets.only(top:10),
              decoration: BoxDecoration(border:Border.all(color:Colors.grey)),
              child: TextButton(child:Text(this.customButton1[0]),onPressed:(){
                setState((){
                  this._pointlist.add(1);
                  this.customCount1[0]++;
                  _updateFiled();
                });
              },),
            ),
            Container(
              margin:EdgeInsets.only(top:10),
              decoration: BoxDecoration(border:Border.all(color:Colors.grey)),
              child: TextButton(child:Text(this.customButton1[1],),onPressed:(){
                setState((){
                  this._pointlist.add(1);
                  this.customCount1[1]++;
                  _updateFiled();
                });
              },),
            ),
            Container(
              margin:EdgeInsets.only(top:10),
              decoration: BoxDecoration(border:Border.all(color:Colors.grey)),
              child: TextButton(child:Text(this.customButton1[2],),onPressed:(){
                setState((){
                  this._pointlist.add(1);
                  this.customCount1[2]++;
                  _updateFiled();
                });
              },),
            ),
            Container(
              margin:EdgeInsets.only(top:10),
              decoration: BoxDecoration(border:Border.all(color:Colors.grey)),
              child: TextButton(child:Text(this.customButton1[3],),onPressed:(){
                setState((){
                  this._pointlist.add(1);
                  this.customCount1[3]++;
                  _updateFiled();
                });
              },),
            ),
          ],
        ),
        Column(
          children:[
            Container(
              margin:EdgeInsets.only(top:10,left:10,),
              decoration: BoxDecoration(border:Border.all(color:Colors.grey)),
              child: TextButton(child:Text(this.customButton2[0],style:TextStyle(color:Colors.red)),onPressed:(){
                setState((){
                  this._pointlist.add(-1);
                  this.customCount2[0]++;
                  _updateFiled();
                });
              },),
            ),
            Container(
              margin:EdgeInsets.only(top:10,left:10,),
              decoration: BoxDecoration(border:Border.all(color:Colors.grey)),
              child: TextButton(child:Text(this.customButton2[1],style:TextStyle(color:Colors.red)),onPressed:(){
                setState((){
                  this._pointlist.add(-1);
                  this.customCount2[1]++;
                  _updateFiled();
                });
              },),
            ),
            Container(
              margin:EdgeInsets.only(top:10,left:10,),
              decoration: BoxDecoration(border:Border.all(color:Colors.grey)),
              child: TextButton(child:Text(this.customButton2[2],style:TextStyle(color:Colors.red)),onPressed:(){
                setState((){
                  this._pointlist.add(-1);
                  this.customCount2[2]++;
                  _updateFiled();
                });
              },),
            ),
            Container(
              margin:EdgeInsets.only(top:10,left:10,),
              decoration: BoxDecoration(border:Border.all(color:Colors.grey)),
              child: TextButton(child:Text(this.customButton2[3],style:TextStyle(color:Colors.red)),onPressed:(){
                setState((){
                  this._pointlist.add(-1);
                  this.customCount2[3]++;
                  _updateFiled();
                });
              },),
            ),
          ],
        ),
      ]
    );
  }

  Widget settingButton(){
    return TextButton(
      child:Text('次のセットへ'),
      onPressed:(){
        setState((){
          this.mypoint.add('0');
          this.yourpoint.add('0');
          this._pointlist.clear();
          for(int i = 0; i<this.customCount1.length; i++){
            this.customCount1[i] = 0;
          }
          for(int i = 0; i<this.customCount2.length; i++){
            this.customCount2[i] = 0;
          }
        });
      },
    );
  }
}