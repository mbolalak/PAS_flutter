import 'dart:convert';


class PremierLeagueModel {
  List<Team> teams;

  PremierLeagueModel({required this.teams});

  
  factory PremierLeagueModel.fromJson(dynamic json) {
    if (json is List) {
      return PremierLeagueModel(
        teams: json.map((x) => Team.fromJson(x as Map<String, dynamic>)).toList(),
      );
    } else if (json is Map<String, dynamic>) {
      final list = json["teams"] ?? json["deals"] ?? json["data"];
      if (list is List) {
        return PremierLeagueModel(
          teams: list.map((x) => Team.fromJson(x as Map<String, dynamic>)).toList(),
        );
      }
    }
    return PremierLeagueModel(teams: []);
  }

  Map<String, dynamic> toJson() => {
        "teams": List<dynamic>.from(teams.map((x) => x.toJson())),
      };
}

class Team {
  String idTeam;
  String strTeam;
  String strStadium;
  String strBadge;
  String strDescriptionEn;

  Team({
    required this.idTeam,
    required this.strTeam,
    required this.strStadium,
    required this.strBadge,
    required this.strDescriptionEn,
  });

  
  String get id => idTeam;
  String get title => strTeam;
  String get subtitle => strStadium;
  String get imageUrl => strBadge;
  String get description => strDescriptionEn;

  factory Team.fromJson(Map<String, dynamic> json) {

    String id = json["idTeam"]?.toString() ??
        json["dealID"]?.toString() ??
        json["id"]?.toString() ??
        "";

    String name = json["strTeam"] ??
        json["title"] ??
        json["name"] ??
        "Tanpa Nama";

   
    String stadium = json["strStadium"] ??
        (json["salePrice"] != null
            ? "Sale: \$${json['salePrice']} (Normal: \$${json['normalPrice'] ?? '-'})"
            : (json["subtitle"] ?? ""));

   
    String badge = json["strBadge"] ??
        json["thumb"] ??
        json["image"] ??
        "";

  
    String desc = json["strDescriptionEn"] ??
        (json["steamRatingText"] != null
            ? "Rating: ${json['steamRatingText']}"
            : (json["description"] ?? ""));

    return Team(
      idTeam: id,
      strTeam: name,
      strStadium: stadium,
      strBadge: badge,
      strDescriptionEn: desc,
    );
  }

  Map<String, dynamic> toJson() => {
        "idTeam": idTeam,
        "strTeam": strTeam,
        "strStadium": strStadium,
        "strBadge": strBadge,
        "strDescriptionEn": strDescriptionEn,
      };
}
