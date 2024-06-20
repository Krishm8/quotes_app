import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quotes_app/controller/home_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> jmap =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    return Scaffold(
      appBar: AppBar(
        actions: [
          InkWell(
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Add to Favorite"),
                ),
              );
              Provider.of<HomeProvider>(context,listen: false).addQuotes(jmap);
              Provider.of<HomeProvider>(context,listen: false).saveQuotes;
            },
              child: Icon(Icons.favorite)),
          SizedBox(width: 10,),
        ],
      ),
      body: Align(
        alignment: Alignment(0,-0.5),
        child: Container(
          padding: EdgeInsets.all(28),
          height: 500,
          width: 300,
          color: Colors.black12,
          child: Column(
            mainAxisAlignment:
            MainAxisAlignment.center,
            children: [
              Text(
                "${jmap["content"]}",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w500
                ),
              ),
              SizedBox(height: 50,),
              Text(
                "- ${jmap["author"]}",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
