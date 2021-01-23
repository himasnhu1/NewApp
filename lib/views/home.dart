import 'package:flutter/material.dart';
import 'package:newsapp/helper/data.dart';
import 'package:newsapp/helper/news.dart';
import 'package:newsapp/models/article_model.dart';
import 'package:newsapp/models/catergory_model.dart';
import 'package:newsapp/views/category_news.dart';

import 'article_view.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategoryModel> categories = new List<CategoryModel>();
  List<ArticleModel> articles = new List<ArticleModel>();

  bool _loading;

  @override
  void initState() {
    _loading = true;
    // TODO: implement initState
    super.initState();
    categories = getcategories();
    getnews();
  }

  void getnews() async {
    News newsClass = News();
    await newsClass.getNews();
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
        elevation: 0.0,
      ),
      body: _loading
          ? Center(
                child: CircularProgressIndicator(),
              )
          : SingleChildScrollView(
            child: Container(
                child: Column(
                  children: <Widget>[
                    ///Categories
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      height: 70,
                      child: ListView.builder(
                          itemCount: categories.length,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return CategoryTile(
                              imageUrl: categories[index].imageUrl,
                              catergoryName: categories[index].categoryName,
                            );
                          }),
                    ),

                    ///Blogs
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
          ),
    );
  }
}

class CategoryTile extends StatelessWidget {
  final String imageUrl, catergoryName;
  CategoryTile({this.imageUrl, this.catergoryName});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => CategoryNews(
            category:catergoryName.toLowerCase(),
          )
        ));
      },
      child: Container(
        margin: EdgeInsets.only(right: 16),
        child: Stack(
          children: <Widget>[
            ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Image.network(
                  imageUrl,
                  width: 120,
                  height: 60,
                  fit: BoxFit.cover,
                )),
            Container(
              alignment: Alignment.center,
              width: 120,
              height: 60,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: Colors.black26),
              child: Text(
                catergoryName,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class BlogTile extends StatelessWidget {
  final String imageUrl, title, desc,url;
  BlogTile(
      {@required this.imageUrl, @required this.title, @required this.desc,@required this.url});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:(){
        Navigator.push(context, MaterialPageRoute(
          builder: (context) =>ArticleView(
             blogUrl: url,
          )
        ));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 16),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
                child: Image.network(imageUrl)),
            SizedBox(height:8),
            Text(title,style: TextStyle(fontSize: 19,color: Colors.black,fontWeight: FontWeight.w500)),
             SizedBox(height:8),
            Text(desc,style: TextStyle(color: Colors.black45,fontWeight: FontWeight.w500))],

        ),
      ),
    );
  }
}
