// import 'package:flutter/material.dart';
//
// class HomeProvider extends ChangeNotifier{
//   int ipage = 1;
//   List<dynamic> favorite=[];
//
// }

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeProvider extends ChangeNotifier {
  int ipage = 1;
  List<Map<String, dynamic>> favorite = [];

  List<Map<String, dynamic>> get _likedQuotes => favorite;

  QuotesProvider() {
    loadQuotes();
  }

  void nextPage() {
    ipage++;
    notifyListeners();
  }

  void previousPage() {
    if (ipage > 1) {
      ipage--;
      notifyListeners();
    }
  }

  void addQuotes(Map<String, dynamic> quote) {
    favorite.add(quote);
    saveQuotes();
    notifyListeners();
  }

  void removeQuote(dynamic quote) {
    favorite.remove(quote);
    saveQuotes();
    notifyListeners();
  }

  void saveQuotes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('likedQuotes', jsonEncode(favorite));
  }

  void loadQuotes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? likedQuotesJson = prefs.getString('likedQuotes');
    if (likedQuotesJson != null) {
      favorite = (jsonDecode(likedQuotesJson) as List<dynamic>)
          .cast<Map<String, dynamic>>();
    }
    notifyListeners();
  }
}