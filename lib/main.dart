import 'package:flutter/material.dart';
import 'package:dev_analysis/Tab1.dart';
import 'package:dev_analysis/Tab2.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin{
  final List<Tab> tabs = <Tab>[
    Tab(text:'集計'),
    Tab(text:'設定'),
  ];
  late TabController _tabController;
  @override
  void initState(){
    super.initState();
    _tabController = TabController(length:tabs.length, vsync:this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:Colors.blue,
        title:TabBar(
          tabs:tabs,
          controller:_tabController,
          unselectedLabelColor:Colors.grey,
          indicatorColor:Colors.lightBlue,
          indicatorSize:TabBarIndicatorSize.tab,
          indicatorWeight:2,
          indicatorPadding:EdgeInsets.symmetric(horizontal:18.0,vertical:8),
          labelColor:Colors.white,
        ),
      ),
      body: TabBarView(
        controller:_tabController,
        children: tabs.map((tab){
          return _createTab(tab);
        }).toList(),
      ),
    );
  }
  Widget _createTab(Tab tab){
    if(tabs[0] == tab){
      return Tab1();
    } else {
      return Tab2();
    }
  }
}
