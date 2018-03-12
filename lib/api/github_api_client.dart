import 'dart:async';
import 'dart:convert' show JSON, LineSplitter, UTF8;
import 'dart:io';

import 'package:flutter_app/model/github_repo.dart';


class GithubClient {

  Future<List<GithubRepo>> get(String query) async {
    var url = 'https://api.github.com/search/repositories?sort=stars&q=';
    var httpClient = new HttpClient();

    List<GithubRepo> result;

    try {
      var request = await httpClient.getUrl(Uri.parse(url + query));
      var response = await request.close();
      if (response.statusCode == HttpStatus.OK) {
        var json = await response.transform(UTF8.decoder).join();
        result = GithubRepo.fromJson(json);
        return result;
      } else {
        return result;
      }
    } catch (exception) {
      return result;
    }
  }
}
