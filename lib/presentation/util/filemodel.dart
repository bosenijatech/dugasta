class AttachModel {
  String? mimetype;
  String? filename;
  String? filedata;

  AttachModel(this.mimetype, this.filename, this.filedata);

  AttachModel.fromJson(Map<String, dynamic> json) {
    mimetype = json['mimetype'];
    filename = json['filename'];
    filedata = json['filedata'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['mimetype'] = mimetype;
    data['filename'] = filename;
    data['filedata'] = filedata;

    return data;
  }
}
