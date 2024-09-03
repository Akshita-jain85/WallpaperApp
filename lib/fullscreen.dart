import 'package:flutter/material.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class Fullscreen extends StatefulWidget {
  final String imageurl;
  const Fullscreen({super.key, required this.imageurl});
  @override
  State<Fullscreen> createState() => _FullscreenState();
}

class _FullscreenState extends State<Fullscreen> {
  Future <void>setwallpaper()async{
int Location = WallpaperManager.HOME_SCREEN;
var file = await  DefaultCacheManager().getSingleFile(widget.imageurl);
bool result = await WallpaperManager.setWallpaperFromFile(file.path, Location) ;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Container(
                child: Image.network(widget.imageurl ),
              ),
            ),InkWell(
              onTap: (){
                setwallpaper();
              },
              child: Container(
                height: 60,
                width: double.infinity,
                color: Colors.black,
                child: Center(
                  child: Text(
                    ('Set Wallpaper'),
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
