import 'package:flutter/material.dart';
import 'package:newsfeed/themes/colors.dart';

class NewsFeed extends StatefulWidget {
  const NewsFeed({super.key});

  @override
  State<NewsFeed> createState() => _NewsFeedState();
}

class _NewsFeedState extends State<NewsFeed> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:bodybg,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor:const Color.fromARGB(255,12, 84, 190),  
        title:const  Text('My News',style: TextStyle(fontWeight:FontWeight.bold,color: Colors.white),),
        actions:const  [
          Padding(padding: EdgeInsets.only(right: 12),
          child:
          Row(
            children: [
              Icon(Icons.rocket_launch,color: Colors.white,),
              Text('IN',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),)
            ],
          )
          ),
        ],
      ),
      body:
    Center(
      child:Text('News Feed'),
    ),
    );
  }
}