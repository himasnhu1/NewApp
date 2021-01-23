
import 'package:flutter/material.dart';
import 'package:newsapp/helper/news.dart';
import 'package:newsapp/models/article_model.dart';
import 'package:newsapp/views/article_view.dart';

import 'home.dart';

class CategoryNews extends StatefulWidget {
  final String category;
  CategoryNews({this.category});
  @override
  _CategoryNewsState createState() => _CategoryNewsState();
}
class _CategoryNewsState extends State<CategoryNews> {
  List<ArticleModel> articles = new List();

  bool _loading =true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCategorynews();
  }

  void getCategorynews() async {
   CategoryNewsClass newsClass = CategoryNewsClass();
    await newsClass.getNews(widget.category);
    articles = newsClass.news;
    setState(() {
      _loading = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Real"),
            Text("News", style: TextStyle(color: Colors.blue))
          ],
        ),
        actions: <Widget>[
          Opacity(
            opacity:0,
            child: Container(
                padding:EdgeInsets.symmetric(horizontal: 16),child: Icon(Icons.save)),
          )
        ],
        elevation: 0.0,
      ),
      body: _loading
        ? Center(
        child: CircularProgressIndicator(),
    )
        : SingleChildScrollView(
          child: Column(
          children:<Widget>[
            Container(
              margin: EdgeInsets.only(top:10),
              child: ListView.builder(
                  padding: EdgeInsets.all(12),
                  itemCount: articles.length,
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return BlogTile(
                      imageUrl: articles[index].urlToImage,
                      title: articles[index].title,
                      desc: articles[index].description,
                      url: articles[index].url,
                    );
                  }),
            )

          ],
      ),
        ),
    );
  }
}
