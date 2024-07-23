import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:quotes_app/controller/home_controller.dart';
import 'package:quotes_app/model/db_helper.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final HomeController controller = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    List data = ModalRoute.of(context)?.settings.arguments as List;
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail"),
      ),
      body: Stack(
        children: [
          Center(
            child: Container(
              height: 500,
              width: 350,
              padding: EdgeInsets.all(20),
              color: Colors.black12,
              child: Center(
                child: Text(
                  data[0],
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 35),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 80,
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    onPressed: () async {
                      var quote = controller.qList[0].happiness![data[1]];
                      DbHelper helper = DbHelper();
                      bool quoteExists = await helper.checkquote(quote);

                      if (quoteExists) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content:
                            Text('Quote is already in favorites'),
                          ),
                        );
                      } else {
                        await helper.insertFavorite(quote, 'happiness',
                            image:
                            controller.qList[0].happinessImage ?? '');

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Quote added to favorites'),
                          ),
                        );
                      }
                    },
                    icon: Icon(
                      Icons.favorite_border,
                      size: 40,
                    ),
                  ),
                  Icon(Icons.share,size: 40,),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
