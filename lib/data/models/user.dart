import 'dart:convert';

class User {
  final String id;
  final String name;
  final String email;
  final String avatarUrl;
  final int ridesCount;
  final double kilometers;
  final double hours;
  final List<String> favoriteVehiclesIds;
  final String preferredLanguageCode;
  final String preferredTheme;
  final String preferredPrimaryColorHex;

  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.avatarUrl,
    required this.ridesCount,
    required this.kilometers,
    required this.hours,
    required this.favoriteVehiclesIds,
    required this.preferredLanguageCode,
    required this.preferredTheme,
    required this.preferredPrimaryColorHex,
  });

  User copyWith({
    String? name,
    String? email,
    String? avatarUrl,
    int? ridesCount,
    double? kilometers,
    double? hours,
    List<String>? favoriteVehiclesIds,
    String? preferredLanguageCode,
    String? preferredTheme,
    String? preferredPrimaryColorHex,
  }) {
    return User(
      id: id,
      name: name ?? this.name,
      email: email ?? this.email,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      ridesCount: ridesCount ?? this.ridesCount,
      kilometers: kilometers ?? this.kilometers,
      hours: hours ?? this.hours,
      favoriteVehiclesIds: favoriteVehiclesIds ?? this.favoriteVehiclesIds,
      preferredLanguageCode:
          preferredLanguageCode ?? this.preferredLanguageCode,
      preferredTheme: preferredTheme ?? this.preferredTheme,
      preferredPrimaryColorHex:
          preferredPrimaryColorHex ?? this.preferredPrimaryColorHex,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'avatarUrl': avatarUrl,
      'ridesCount': ridesCount,
      'kilometers': kilometers,
      'hours': hours,
      'favoriteVehiclesIds': favoriteVehiclesIds,
      'preferredLanguageCode': preferredLanguageCode,
      'preferredTheme': preferredTheme,
      'preferredPrimaryColorHex': preferredPrimaryColorHex,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      avatarUrl: map['avatarUrl'] as String,
      ridesCount: map['ridesCount'] as int,
      kilometers: (map['kilometers'] as num).toDouble(),
      hours: (map['hours'] as num).toDouble(),
      favoriteVehiclesIds:
          List<String>.from(map['favoriteVehiclesIds'] as List<dynamic>),
      preferredLanguageCode: map['preferredLanguageCode'] as String,
      preferredTheme: map['preferredTheme'] as String,
      preferredPrimaryColorHex: map['preferredPrimaryColorHex'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);
}
