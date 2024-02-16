class RecordModel {
  int? id;
  String? title;

  String? file;
  String? audioLength;
 
  // Constructor
  RecordModel(
      {this.id,
       this.file,
      this.title,
      this.audioLength,
     });

  factory RecordModel.fromJson(Map<String, dynamic> json) {
    return RecordModel(
      id: json['id'] ?? 0,
      file: json['file_path'] ?? '',
      title: json['title'] ?? '',
      audioLength: json['time'] ?? '',
      
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'file_path': file,
      'title': title,
      'length': audioLength,
      
    };
  }
}
