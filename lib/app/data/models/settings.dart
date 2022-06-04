class Settings {
  String name;
  String fullName;

  Settings({
    required this.name,
    required this.fullName,
  });

  factory Settings.fromJson(Map<String, dynamic> json) => Settings(name: json['name'], fullName: json['fullName']);

  Map<String, dynamic> toJson() => {
        'name': name,
        'fullname': fullName,
      };
}
