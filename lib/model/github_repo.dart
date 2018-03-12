import 'dart:convert';

class GithubRepo {
  var name;
  var starCount;
  var avatarUrl;

  static fromJson(json) {
    var data = JSON.decode(json);
    List<Map<String, Object>> itemList = data['items'];

    return itemList.map((item) {
      var repo = new GithubRepo();
      Map<String, Object> owner = item['owner'];
      repo.avatarUrl = owner['avatar_url'];
      repo.name = item['full_name'];
      repo.starCount = item['stargazers_count'];
      return repo;
    }).toList();
  }
}
