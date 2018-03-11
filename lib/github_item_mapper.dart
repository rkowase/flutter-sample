import 'package:flutter_app/github_repo.dart';
import 'dart:convert' show JSON;

class GithubItemsMapper {
  static List<GithubRepo> create(String jsonString) {
    Map<String, Object> root = JSON.decode(jsonString);
    List<Map<String, Object>> json = root['items'];

    return json.map((dic) {
      var item = new GithubRepo();
      item.name = dic['name'];
      return item;
    }).toList();
  }
}
