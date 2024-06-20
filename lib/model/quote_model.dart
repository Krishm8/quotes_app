import 'dart:convert';

QuoteModel quoteModelFromJson(String str) => QuoteModel.fromJson(json.decode(str));

String quoteModelToJson(QuoteModel data) => json.encode(data.toJson());

class QuoteModel {
  int? count;
  int? totalCount;
  int? page;
  int? totalPages;
  int? lastItemIndex;
  List? results;

  QuoteModel({
    this.count,
    this.totalCount,
    this.page,
    this.totalPages,
    this.lastItemIndex,
    this.results,
  });

  factory QuoteModel.fromJson(Map<String, dynamic> json) => QuoteModel(
    count: json["count"],
    totalCount: json["totalCount"],
    page: json["page"],
    totalPages: json["totalPages"],
    lastItemIndex: json["lastItemIndex"],
    results: json["results"],
  );

  Map<String, dynamic> toJson() => {
    "count": count,
    "totalCount": totalCount,
    "page": page,
    "totalPages": totalPages,
    "lastItemIndex": lastItemIndex,
    "results": results == null ? [] : List<dynamic>.from(results!.map((x) => x.toJson())),
  };
}

class Result {
  String? id;
  Author? author;
  String? content;
  List<String>? tags;
  AuthorSlug? authorSlug;
  int? length;
  DateTime? dateAdded;
  DateTime? dateModified;

  Result({
    this.id,
    this.author,
    this.content,
    this.tags,
    this.authorSlug,
    this.length,
    this.dateAdded,
    this.dateModified,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["_id"],
    author: authorValues.map[json["author"]]!,
    content: json["content"],
    tags: json["tags"] == null ? [] : List<String>.from(json["tags"]!.map((x) => x)),
    authorSlug: authorSlugValues.map[json["authorSlug"]]!,
    length: json["length"],
    dateAdded: json["dateAdded"] == null ? null : DateTime.parse(json["dateAdded"]),
    dateModified: json["dateModified"] == null ? null : DateTime.parse(json["dateModified"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "author": authorValues.reverse[author],
    "content": content,
    "tags": tags == null ? [] : List<dynamic>.from(tags!.map((x) => x)),
    "authorSlug": authorSlugValues.reverse[authorSlug],
    "length": length,
    "dateAdded": "${dateAdded!.year.toString().padLeft(4, '0')}-${dateAdded!.month.toString().padLeft(2, '0')}-${dateAdded!.day.toString().padLeft(2, '0')}",
    "dateModified": "${dateModified!.year.toString().padLeft(4, '0')}-${dateModified!.month.toString().padLeft(2, '0')}-${dateModified!.day.toString().padLeft(2, '0')}",
  };
}

enum Author {
  CHARLES_DICKENS,
  THOMAS_EDISON
}

final authorValues = EnumValues({
  "Charles Dickens": Author.CHARLES_DICKENS,
  "Thomas Edison": Author.THOMAS_EDISON
});

enum AuthorSlug {
  CHARLES_DICKENS,
  THOMAS_EDISON
}

final authorSlugValues = EnumValues({
  "charles-dickens": AuthorSlug.CHARLES_DICKENS,
  "thomas-edison": AuthorSlug.THOMAS_EDISON
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}


