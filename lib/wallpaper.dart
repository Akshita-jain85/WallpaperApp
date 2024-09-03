import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wallapperapp/fullscreen.dart';

class Wallpaper extends StatefulWidget {


  const Wallpaper({super.key});

  @override
  State<Wallpaper> createState() => _WallpaperState();
}

class _WallpaperState extends State<Wallpaper> {
  List images = [];
  int page = 1;
  void initState(){
    super.initState();
    fetchapi();
  }
  loadmore()async{
setState(() {
  page = page+1;
});
String url = 'https://api.pexels.com/v1/curated?per_page=80&page='+page.toString();
await http.get(Uri.parse('https://api.pexels.com/v1/curated?per_page=80'),
    headers: {
      'Authorization':
      '1GdFA4BD9J9a4IXvDumoLrzuWnM2RM00Tei5xWup9hFtXKM2NDOpykta'
    }).then((value){
      Map result = jsonDecode(value.body);
      setState(() {
        images.addAll(result['photos']);
      });
});
  }
  fetchapi() async {
    await http.get(Uri.parse('https://api.pexels.com/v1/curated?per_page=80'),
        headers: {
          'Authorization':
          '1GdFA4BD9J9a4IXvDumoLrzuWnM2RM00Tei5xWup9hFtXKM2NDOpykta'
        }).then((value) {
          Map result = jsonDecode(value.body);
setState(() {
  images = result['photos'];
});
          print(images[0]);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
              child: Container(
            child: GridView.builder(
                itemCount: images.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 2,
                    childAspectRatio: 2 / 3,
                    mainAxisSpacing: 2),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Fullscreen(imageurl: images[index]['src']['large2x'],)));
                    },
                    child: Container(
                      color: Colors.white,
                      child: Image.network(images[index]['src']['tiny'],fit: BoxFit.cover,),
                    ),
                  );
                }),
          )),
          InkWell(
            onTap: (){
              loadmore();
            },
            child: Container(
              height: 60,
              width: double.infinity,
              color: Colors.black,
              child: Center(
                child: Text(
                  ('Load More'),
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
