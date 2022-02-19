import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dev_analysis/db/Setting.dart';

class Tab2 extends StatefulWidget {
  @override
  State<StatefulWidget> createState(){
    return _Tab2();
  }
}
class _Tab2 extends State<Tab2> {
  List<Widget> widgetList = [];
  List<Widget> widgetList2 = [];
  List<String> registlist = [];
  List<String> registlist2 = [];
  var _buttonController = TextEditingController();
  int radiovalue = 1;
  String _type = '1';

  @override
  Widget build(BuildContext context){
    return 
    SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child:
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children:[
            Row(
              children:[
                Radio(
                  activeColor:Colors.blue,
                  value: '1',
                  groupValue: _type,
                  onChanged:(value){setState((){_type = '1';});},
                ),
                Text('得点ボタン作成'),
                Radio(
                  activeColor:Colors.blue,
                  value: '2',
                  groupValue: _type,
                  onChanged:(value){setState((){_type = '2';});},
                ),
                Text('失点ボタン作成'),
              ],
            ),
            Row(
              children:[
                Text('テキスト：'),
                Flexible(
                  child:TextField(
                    decoration: InputDecoration(hintText:' 表示名を入力...'),
                    controller: _buttonController,
                  ),
                ),
              ],
            ),
            Row(
              children:[
                Container(
                  child:TextButton(child:Text('追加'),onPressed:(){
                      setState((){
                        if('1' == _type){
                          addCustomButton(_buttonController.text);
                        } else {
                          addCustomButton2(_buttonController.text);
                        }
                      });
                    },
                  ),
                ),
                Container(
                  child:TextButton(child:Text('登録'),onPressed:(){regist();setState((){});},),
                ),
                Container(
                  child:TextButton(child:Text('表示'),onPressed:(){display();},),
                ),
                Container(
                  child:TextButton(child:Text('削除'),onPressed:(){delteAllData();},),
                ),
              ],
            ),
            Container(
              decoration: BoxDecoration(border:Border.all(color:Colors.blue)),
              height: 200,
              padding: EdgeInsets.only(top:10,bottom:10),
              child:
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:registedData(),
                ),
            ),
          ],
        )
    );
  }
  /** 登録済みデータ */
  List<Widget> registedData(){
    List<Widget> datalist = [];
    List<Widget> tokutenlist = [];
    tokutenlist.add(Container(child:Text('得点ボタン',style:TextStyle(color:Colors.blue)),margin:EdgeInsets.only(bottom:10)));
    for(String data in registlist){
      tokutenlist.add(Text('$data',style:TextStyle(color:Colors.blue)));
    }
    datalist.add(
      Column(
        
        mainAxisAlignment: MainAxisAlignment.start,
        children:tokutenlist,
      )
    );
    datalist.add(
      Container(
        margin:EdgeInsets.only(left:20),
      )
    );
    List<Widget> sittenlist = [];
    sittenlist.add(Container(child:Text('失点ボタン',style:TextStyle(color:Colors.red)),margin:EdgeInsets.only(bottom:10)));
    for(String data in registlist2){
      sittenlist.add(Text('$data',style:TextStyle(color:Colors.red)));
    }
    datalist.add(
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children:sittenlist,
      )
    );
    return datalist;
  }
  /** カスタムボタン追加 */
  void addCustomButton(String str){
    widgetList.add(
      TextButton(
        child:Text('$str'),
        onPressed: (){},
      )
    );
    registlist.add(str);
  }
  /** カスタムボタン追加2 */
  void addCustomButton2(String str){
    widgetList2.add(
      TextButton(
        child:Text('$str',style:TextStyle(color:Colors.red)),
        onPressed: (){},
      )
    );
    registlist2.add(str);
  }
  /** 登録 */
  void regist() async{
    String custom1 = jsonEncode(registlist);
    String custom2 = jsonEncode(registlist2);
    Setting set = new Setting(recId:1,custom1:custom1,custom2:custom2);
    Setting.insertData(set);
  }
  /** 表示 */
  void display() async{
    List<Setting> settinglist = await Setting.getDatas();
    setState((){
      if(settinglist.length > 0){
        dynamic json1 = jsonDecode(settinglist[0].custom1);
        dynamic json2 = jsonDecode(settinglist[0].custom2);
        registlist.clear();
        registlist2.clear();
        for(int i = 0; i<json1.length; i++){
          registlist.add(json1[i]);
        }
        for(int i = 0; i<json2.length; i++){
          registlist2.add(json2[i]);
        }
      }
    });
  }
  /** 削除 */
  void delteAllData() async{
    setState((){
      Setting.deleteData(0);
    });
  }
}