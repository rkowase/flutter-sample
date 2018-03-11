import 'dart:async';
import 'dart:convert' show JSON, LineSplitter, UTF8;
import 'dart:io';

import 'package:flutter_app/github_repo.dart';


class GithubClient {

  Future<List<GithubRepo>> get(String query) async {
    var url = 'https://api.github.com/search/repositories?q=';
    var httpClient = new HttpClient();

    List<GithubRepo> result;

    try {
      var request = await httpClient.getUrl(Uri.parse(url + query));
      var response = await request.close();
      if (response.statusCode == HttpStatus.OK) {
        var json = await response.transform(UTF8.decoder).join();
        var data = JSON.decode(json);
        List<Map<String, Object>> list = data['items'];

        result = list.map((dic) {
          var item = new GithubRepo();
          item.name = dic['full_name'];
          return item;
        }).toList();

        return result;
      } else {
        return result;
      }
    } catch (exception) {
      return result;
    }
  }
}
