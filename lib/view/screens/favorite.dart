import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quotes_app/controller/favorite_controller.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  FavoriteController favController = Get.put(FavoriteController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Favorite Quotes",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Obx(
        () {
          return favController.favlist.isEmpty
              ? Center(child: Text("No Favorite Quotes"))
              : ListView.separated(
                  separatorBuilder: (context, index) {
                    return Divider();
                  },
                  itemCount: favController.favlist.length,
                  itemBuilder: (context, index) {
                    var fav = favController.favlist[index];
                    return Stack(
                      children: [
                        ListTile(
                          title: Text(
                            "${fav['favquotes']}",
                            maxLines: 1,
                            style: TextStyle(
                              overflow: TextOverflow.ellipsis,
                              fontSize: 20,
                            ),
                          ),
                          trailing: IconButton(
                            onPressed: () {
                              favController.removefavQuotes(fav['id'] ?? '');
                            },
                            icon: Icon(Icons.delete),
                            color: Colors.red,
                          ),
                        ),
                      ],
                    );
                  },
                );
        },
      ),
    );
  }
}
