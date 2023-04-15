class ProfileToPlayModel {
  int? count;
  String? next;
  String? previous;
  List<Results>? results;

  ProfileToPlayModel({this.count, this.next, this.previous, this.results});

  ProfileToPlayModel.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results!.add(Results.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['count'] = count;
    data['next'] = next;
    data['previous'] = previous;
    if (results != null) {
      data['results'] = results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Results {
  int? id;
  int? user;
  String? image;
  String? userName;
  String? email;

  Results({this.id, this.user, this.image, this.userName, this.email});

  Results.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'];
    image = json['image'];
    userName = json['user_name'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user'] = user;
    data['image'] = image;
    data['user_name'] = userName;
    data['email'] = email;
    return data;
  }
}
