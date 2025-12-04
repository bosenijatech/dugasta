import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class StatisticScreenView extends StatefulWidget {
  const StatisticScreenView({Key? key}) : super(key: key);

  @override
  _StatisticScreenViewState createState() => _StatisticScreenViewState();
}

class _StatisticScreenViewState extends State<StatisticScreenView>
    with TickerProviderStateMixin {
  TabController? controller;
  @override
  void initState() {
    super.initState();
    controller = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    controller!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: <Widget>[
          TabBar.secondary(
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey,
            controller: controller,
            indicatorColor: Colors.blue,
            indicator: const BoxDecoration(
              color: Colors.lightBlueAccent,
            ),
            tabs: const <Widget>[
              Tab(
                text: 'Tab 1',
              ),
              Tab(
                text: 'Tab 2',
              ),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: controller,
              children: const <Widget>[
                Card(
                  child: Center(
                      child: Text(
                    'This is the first tab',
                  )),
                ),
                Card(
                  child: Center(
                      child: Text(
                    'This is the second tab',
                  )),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
