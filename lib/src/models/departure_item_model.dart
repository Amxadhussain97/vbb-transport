import 'dart:convert';

class DepartureItemModel {
  final String? stop;
  final DateTime? when;
  final String? platform;
  final String? direction;
  final int? delay;
  final Map<String, dynamic>? line;
  final List<Map<String, dynamic>>? remarks;
  final Map<String, dynamic>? destination;

  DepartureItemModel({
    required this.stop,
    required this.when,
    required this.platform,
    required this.direction,
    required this.delay,
    required this.line,
    required this.remarks,
    required this.destination,
  });

  // factory DepartureItemModel.fromRawJson(String str) => DepartureItemModel.fromJson(json.decode(str));

  factory DepartureItemModel.fromJson(Map<String, dynamic> json) => DepartureItemModel(

    stop: json["stop"]["name"] ?? '',
    when:  json["when"] ? DateTime.parse(json["when"]) : null,
    // when: json["when"] != null ? DateTime.parse(json["when"]) : null,
    platform: json["platform"] ?? '',
    direction: json["direction"] ?? '',
    delay: json["delay"] ?? 0,
    line: json["line"] == null ? {} : json["line"] as Map<String, dynamic>,
    remarks: json["remarks"] == null ? [] : List<Map<String, dynamic>>.from(json["remarks"].map((x) => x as Map<String, dynamic>)),
    destination: json["destination"] == null ? {} : json["destination"] as Map<String, dynamic>,


  );





}
