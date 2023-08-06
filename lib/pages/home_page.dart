import "package:flutter/material.dart";
import 'package:news_app/models/newsinfo';
import 'package:news_app/services/api_manager.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<NewsModel> _newsModel;

  @override
  void initState() {
    _newsModel = API_manager().getNews();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('News App')),
      body: Container(
        child: FutureBuilder<NewsModel>(
          future: _newsModel,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data?.articles.length,
                  itemBuilder: (context, index) {
                    var article = snapshot.data?.articles[index];
                    return Container(
                      padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                      height: 400,
                      width: 220,
                      child: Card(
                        elevation: 7,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 2,
                              child: Center(
                                child: Container(
                                  padding: EdgeInsets.all(5),
                                  margin: EdgeInsets.fromLTRB(25, 5, 25, 5),
                                  child: Text(
                                    article!.title,
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 5,
                              child: AspectRatio(
                                aspectRatio: 2 / 1,
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.network(
                                      article.urlToImage,
                                    )),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Container(
                                  padding: EdgeInsets.all(10),
                                  margin: EdgeInsets.fromLTRB(25, 0, 25, 0),
                                  child: Text(article.description,  textAlign: TextAlign.justify,),
                                   
                            )),
                                
                          ],
                        ),
                      ),
                    );
                  });
            } else
              return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
