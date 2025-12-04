import 'package:dugasta/presentation/module/news/newsmodel.dart';
import 'package:dugasta/presentation/util/app_utils.dart';
import 'package:flutter/material.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  List<Newsmodel> newslist = Newsmodel.newslist;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppUtils.buildNormalText(
            text: "News & Update", fontSize: 18, color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            getItemUI(),
          ],
        ),
      ),
    );
  }

  Widget getItemUI() {
    return ListView.builder(
      itemCount: newslist.length,
      shrinkWrap: true,
      physics: ScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return Card(
            child: Column(
          children: <Widget>[
            ListTile(
              leading: Image.asset(
                newslist[index].imagePath,
                fit: BoxFit.cover,
                width: 100.0,
              ),
              title: Text(
                newslist[index].titleTxt.toString(),
                style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                newslist[index].subTxt.toString(),
              ),
              //trailing: ,
              onTap: () {},
            )
          ],
        ));
      },
    );
  }
}
