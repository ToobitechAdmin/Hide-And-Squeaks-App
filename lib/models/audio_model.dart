
class AudioModel {
  int id;
  String title;

  String filePath;
  String time;
  String type;
  String price;
  int count;
  // Constructor
  AudioModel(
      {required this.id,
      required this.filePath,
      required this.title,
      required this.time,
      required this.type,
      required this.price,
      required this.count});

  factory AudioModel.fromJson(Map<String, dynamic> json) {
    return AudioModel(
      id: json['id'] ?? 0,
      filePath: json['file_path'] ?? '',
      title: json['title'] ?? '',
      time: json['time'] ?? '',
      type: json['type'],
      price: json['price'],
      count: json['count'] ?? 0,
      // download: json['download'],
      // bin: json["bin"]
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'file_path': filePath,
      'title': title,
      'time': time,
      "type": type,
      'price': price,
      'count': count
      // "download": download,
      // "bin": bin
    };
  }
}
