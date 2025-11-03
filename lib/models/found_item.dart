class FoundItem {
  final String id;
  final String title;
  final String description;
  final String location;
  final String storage;
  final String email;
  final String date; // dd-mm-yyyy
  final String time; // HH:mm
  final DateTime createdAt;

  const FoundItem({
    required this.id,
    required this.title,
    required this.description,
    required this.location,
    required this.storage,
    required this.email,
    required this.date,
    required this.time,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'location': location,
        'storage': storage,
        'email': email,
        'date': date,
        'time': time,
        'createdAt': createdAt.toIso8601String(),
      };

  factory FoundItem.fromJson(Map<String, dynamic> json) {
    return FoundItem(
      id: json['id'] as String,
      title: json['title'] as String,
      description: (json['description'] as String?) ?? '',
      location: (json['location'] as String?) ?? '',
      storage: (json['storage'] as String?) ?? '',
      email: (json['email'] as String?) ?? '',
      date: (json['date'] as String?) ?? '',
      time: (json['time'] as String?) ?? '',
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }
}


