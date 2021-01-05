class MediaUploadModel {
  String name;
  String originalName;

  MediaUploadModel({this.name, this.originalName});

  MediaUploadModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    originalName = json['original_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['original_name'] = this.originalName;
    return data;
  }
}
