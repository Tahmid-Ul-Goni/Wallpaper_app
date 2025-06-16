import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:share_plus/share_plus.dart';
import 'package:wallpaper_manager_flutter/wallpaper_manager_flutter.dart';

class Details extends StatelessWidget {
  final String imageUrl;
  Details(this.imageUrl);

  @override
  Widget build(BuildContext context) {
    setHomeScreen(url) async {
      try {
        int location = WallpaperManagerFlutter.homeScreen;
        var file = await DefaultCacheManager().getSingleFile(url);
        await WallpaperManagerFlutter().setWallpaper(file, location);
        Fluttertoast.showToast(
          msg: 'Set Successfully',
          toastLength: Toast.LENGTH_LONG,
        );
      } catch (e) {
        print(e);
      }
    }

    setLockScreen(url) async {
      try {
        int location = WallpaperManagerFlutter.lockScreen;
        var file = await DefaultCacheManager().getSingleFile(url);
        await WallpaperManagerFlutter().setWallpaper(file, location);
        Fluttertoast.showToast(
          msg: 'Set successfully',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
        );
      } catch (e) {
        print(e);
      }
    }

    shareImage(url) {
      Share.share(url);
    }

    return Scaffold(
      floatingActionButton: SpeedDial(
        icon: Icons.add,
        children: [
          SpeedDialChild(
            labelBackgroundColor: Colors.amberAccent,
            labelStyle: TextStyle(fontWeight: FontWeight.w600),
            child: const Icon(Icons.lock_outline_sharp, size: 18),
            label: 'Set HomeScreen',
            onTap: () => setHomeScreen(imageUrl),
          ),
          SpeedDialChild(
            labelBackgroundColor: Colors.amberAccent,
            labelStyle: TextStyle(fontWeight: FontWeight.w600),
            child: const Icon(Icons.wallpaper, size: 18),
            label: 'Set LockScreen',
            onTap: () => setLockScreen(imageUrl),
          ),

          SpeedDialChild(
            labelBackgroundColor: Colors.amberAccent,
            labelStyle: TextStyle(fontWeight: FontWeight.w600),
            child: const Icon(Icons.share, size: 18),
            label: 'Share',
            onTap: () => shareImage(imageUrl),
          ),
        ],
      ),
      body: Hero(
        tag: imageUrl,
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(image: NetworkImage(imageUrl)),
          ),
        ),
      ),
    );
  }
}
