import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:newsfeed/models/news_model.dart';
import 'package:newsfeed/pages/news_details.dart';
import 'package:newsfeed/themes/colors.dart';
import 'package:newsfeed/themes/theme_provider.dart';
import 'package:provider/provider.dart';

class NewsFeed extends StatefulWidget {
  const NewsFeed({super.key});

  @override
  State<NewsFeed> createState() => _NewsFeedState();
}

class _NewsFeedState extends State<NewsFeed> {
  late Future<List<Article>> futureArticles;
  late  String countrycode = '';
//Function For Fetching RemoteConfig Details From Firebase
    Future<void> fetchRemoteConfig() async {
    final FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;

    try {
      await remoteConfig.fetch();
      await  await remoteConfig.fetchAndActivate();

      setState(() {
        countrycode = remoteConfig.getString('countrycode');
        futureArticles = NewsService(countryCode: countrycode).fetchTopHeadlines();
      });
    } catch (e) {
      print('Error fetching remote config: $e');
    }
  }


  @override
  void initState() {
    super.initState();
    fetchRemoteConfig();
    futureArticles = NewsService(countryCode: countrycode).fetchTopHeadlines();
  }

  @override
void dispose() {
  // Clean up resources here, if needed
  super.dispose();
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: bodybg,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
         backgroundColor: Theme.of(context).colorScheme.background,
        title: const Text(
          'My News',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        actions:  [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child:IconButton(onPressed: (){
              Provider.of<ThemeProvider>(context,listen: false).toggleTheme();
            },
             icon: Icon(Icons.sunny,color: Theme.of(context).colorScheme.primary),)
          ),
        ],
      ),
      body: Padding(
        padding:const  EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 20),
              child: Text(
                'Top Headlines',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                textAlign: TextAlign.start,
              ),
            ),
            const SizedBox(height: 25),
            Expanded(
              child: FutureBuilder<List<Article>>(
                future: futureArticles,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return const Center(child: Text('No Headlines Available'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No Headlines Available'));
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final article = snapshot.data![index];
                        return  GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => NewsDetailPage(article: article),
                              ),
                            );
                          },
                      child:   Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color:Theme.of(context).colorScheme.primary)
                          ),
                          margin: const EdgeInsets.all(8.0),
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Column(

                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      
                                      article.title,
                                      style: Theme.of(context).textTheme.titleLarge,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 3,
                                    ),
                                   const  SizedBox(height: 10,),
                                    Text(
                                      article.description,
                                      style: Theme.of(context).textTheme.caption,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),
                                  ],
                                ),
                              ),
                            const   SizedBox(width: 10,),
                              if (article.urlToImage.isNotEmpty)
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.network(
                                    article.urlToImage,
                                    height: 120,
                                    width: 120,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                            ],
                          ),
                      ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

