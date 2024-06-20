import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:quotes_app/controller/home_provider.dart';
import 'package:quotes_app/controller/theme_provider.dart';
import 'package:quotes_app/model/api_helper.dart';
import 'package:quotes_app/model/quote_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  QuoteModel? model;

  @override
  void didChangeDependencies() {
    Provider.of<HomeProvider>(context, listen: false).loadQuotes();
    super.didChangeDependencies();
  }

  // @override
  // void didChangeDependencies() {
  //   SharedPreferences.getInstance().then((value) {
  //     var themeMode = value.getInt("themeMode");
  //     print("My Save Val $themeMode");
  //     Provider.of<ThemeProvider>(context, listen: false).changeTheme(themeMode ?? 0);
  //   });
  //   super.didChangeDependencies();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Quotgram",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          // Consumer<ThemeProvider>(
          //   builder: (BuildContext context, value, Widget? child) {
          //     return DropdownButton(
          //       value: value.themeMode,
          //       items: [
          //         DropdownMenuItem(child: Text("System"), value: 0),
          //         DropdownMenuItem(child: Text("Light"), value: 1),
          //         DropdownMenuItem(child: Text("Dark"), value: 2),
          //       ],
          //       onChanged: (value) async {
          //         var instance = await SharedPreferences.getInstance();
          //         instance.setInt("themeMode", value ?? 0);
          //         Provider.of<ThemeProvider>(context, listen: false).changeTheme(value ?? 0);
          //       },
          //     );
          //   },
          // ),
          InkWell(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return Container(
                      padding: EdgeInsets.only(top: 10),
                      child: Column(
                        children:
                            Provider.of<HomeProvider>(context, listen: false)
                                .favorite
                                .map(
                                  (e) => ListTile(
                                    title: Text(e["author"].toString(),style: TextStyle(fontWeight: FontWeight.bold)),
                                    subtitle: Text(e["content"].toString()),
                                    trailing: InkWell(
                                      onTap: () {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content: Text("Remove from Favorite"),
                                          ),
                                        );
                                        Provider.of<HomeProvider>(context,
                                                listen: false)
                                            .removeQuote(e);
                                        Navigator.pop(context);
                                      },
                                      child: Icon(Icons.remove),
                                    ),
                                  ),
                                )
                                .toList(),
                      ),
                    );
                  },
                );
              },
              child: Icon(Icons.favorite)),
          SizedBox(
            width: 10,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: get(Uri.parse(
                  "https://api.quotable.io/quotes?page=${Provider.of<HomeProvider>(context, listen: false).ipage}")),
              builder: (context, snapshot) {
                Response? res = snapshot.data;
                if (res != null) {
                  Map<String, dynamic> apiData = jsonDecode(res.body ?? "");
                  model = QuoteModel.fromJson(apiData);
                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    itemCount: model?.results?.length,
                    itemBuilder: (context, index) {
                      // model.results
                      return InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, "detail",
                              arguments: model?.results?[index]);
                        },
                        child: Container(
                          margin: EdgeInsets.all(10),
                          padding: EdgeInsets.all(10),
                          color: Colors.black12,
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "${model?.results?[index]["content"]}",
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  "- ${model?.results?[index]["author"]}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                onPressed: () {
                  Provider.of<HomeProvider>(context, listen: false)
                      .previousPage();
                },
                icon: Icon(Icons.remove),
              ),
              Text(
                "${Provider.of<HomeProvider>(context, listen: false).ipage}",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                onPressed: () {
                  Provider.of<HomeProvider>(context, listen: false).nextPage();
                },
                icon: Icon(Icons.add),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
