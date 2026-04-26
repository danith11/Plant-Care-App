class Plant {
  String? id;
  String name;
  String type;
  String wateringFrequency;
  String status;

  Plant({
    this.id,
    required this.name,
    required this.type,
    required this.wateringFrequency,
    required this.status,
  });

  factory Plant.fromJson(Map<String, dynamic> json) {
    return Plant(
      id: json['id'],
      name: json['name'],
      type: json['type'],
      wateringFrequency: json['wateringFrequency'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'name': name,
      'type': type,
      'wateringFrequency': wateringFrequency,
      'status': status,
    };

    if (id != null) {
      data['id'] = id;
    }

    return data;
  }
}
