class Tournament {
  int? code;
  Data? data;
  bool? success;

  Tournament({this.code, this.data, this.success});

  Tournament.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['success'] = success;
    return data;
  }
}

class Data {
  String? cursor;
  dynamic tournamentCount;
  List<Tournaments>? tournaments;
  bool? isLastBatch;

  Data({this.cursor, this.tournamentCount, this.tournaments, this.isLastBatch});

  Data.fromJson(Map<String, dynamic> json) {
    cursor = json['cursor'];
    tournamentCount = json['tournament_count'];
    if (json['tournaments'] != null) {
      tournaments = <Tournaments>[];
      json['tournaments'].forEach((v) {
        tournaments!.add(Tournaments.fromJson(v));
      });
    }
    isLastBatch = json['is_last_batch'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cursor'] = cursor;
    data['tournament_count'] = tournamentCount;
    if (tournaments != null) {
      data['tournaments'] = tournaments!.map((v) => v.toJson()).toList();
    }
    data['is_last_batch'] = isLastBatch;
    return data;
  }
}

class Tournaments {
  String? name;
  String? coverUrl;
  String? gameName;

  Tournaments({this.name, this.coverUrl, this.gameName});

  Tournaments.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    coverUrl = json['cover_url'];
    gameName = json['game_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['cover_url'] = coverUrl;
    data['game_name'] = gameName;
    return data;
  }
}
