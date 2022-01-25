class User {
  int? code;
  bool? success;
  UserData? data;

  User({this.code, this.success, this.data});

  User.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    success = json['success'];
    data = json['data'] != null ? UserData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class UserData {
  UserInfo? userInfo;
  TournamentInfo? tournamentInfo;

  UserData({this.userInfo, this.tournamentInfo});

  UserData.fromJson(Map<String, dynamic> json) {
    userInfo = json['user_info'] != null ? UserInfo.fromJson(json['user_info']) : null;
    tournamentInfo = json['tournament_info'] != null ? TournamentInfo.fromJson(json['tournament_info']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (userInfo != null) {
      data['user_info'] = userInfo!.toJson();
    }
    if (tournamentInfo != null) {
      data['tournament_info'] = tournamentInfo!.toJson();
    }
    return data;
  }
}

class UserInfo {
  String? username;
  int? eloRating;
  String? imageUrl;

  UserInfo({this.username, this.eloRating, this.imageUrl});

  UserInfo.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    eloRating = json['elo_rating'];
    imageUrl = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['elo_rating'] = eloRating;
    data['image_url'] = imageUrl;
    return data;
  }
}

class TournamentInfo {
  String? tournamentsPlayed;
  String? tournamentsWon;
  String? winningPercentage;

  TournamentInfo({this.tournamentsPlayed, this.tournamentsWon, this.winningPercentage});

  TournamentInfo.fromJson(Map<String, dynamic> json) {
    tournamentsPlayed = json['tournaments_played'];
    tournamentsWon = json['tournaments_won'];
    winningPercentage = json['winning_percentage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['tournaments_played'] = tournamentsPlayed;
    data['tournaments_won'] = tournamentsWon;
    data['winning_percentage'] = winningPercentage;
    return data;
  }
}
