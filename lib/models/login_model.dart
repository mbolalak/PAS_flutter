import 'dart:convert';

Loginmodel loginmodelFromJson(String str) => Loginmodel.fromJson(json.decode(str));

String loginmodelToJson(Loginmodel data) => json.encode(data.toJson());

class Loginmodel {
  final bool status;
  final String message;
  final String? token; // Tanda '?' agar aman jika null

  Loginmodel({
    required this.status,
    required this.message,
    this.token,
  });

  factory Loginmodel.fromJson(Map<String, dynamic> json) => Loginmodel(
        // Fleksibel menangani status berupa boolean true, integer 1, maupun string "true"
        status: json["status"] == true || json["status"] == 1 || json["status"] == "true",
        message: json["message"]?.toString() ?? "",
        token: json["token"]?.toString(),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "token": token,
      };
}
