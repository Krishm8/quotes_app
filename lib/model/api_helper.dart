// import 'dart:convert';
//
// import 'package:http/http.dart';
// import 'package:quotes_app/model/quote_model.dart';
//
// class ApiHelper {
//   Future<Response> fetchUser() async {
//     Response res =
//         await get(Uri.parse("https://api.quotable.io/quotes?page=1"));
//     Map<String, dynamic> jsonResponse = jsonDecode(res.body);
//     print("response ==========.......... $jsonResponse");
//     String userJson = jsonResponse["totalPages"];
//     // print("response ==========.......... $userJson");
//     // print("response ==========.......... ${User.fromJson(userJson)}");
//     return res;
//   }
// }
