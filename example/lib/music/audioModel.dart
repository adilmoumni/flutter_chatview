class Audio {
  int? nPlaybackNumber;
  String? nameText;
  String? typeText;
  String? createdDate;
  String? slug;
  String? createdBy;
  String? modifiedDate;
  String? file1File;
  String? sId;

  Audio(
      {this.nPlaybackNumber,
      this.nameText,
      this.typeText,
      this.createdDate,
      this.slug,
      this.createdBy,
      this.modifiedDate,
      this.file1File,
      this.sId});

  Audio.fromJson(Map<String, dynamic> json) {
    nPlaybackNumber = json['n_playback_number'];
    nameText = json['name_text'];
    typeText = json['type_text'];
    createdDate = json['Created Date'];
    slug = json['Slug'];
    createdBy = json['Created By'];
    modifiedDate = json['Modified Date'];
    file1File = json['file1_file'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['n_playback_number'] = this.nPlaybackNumber;
    data['name_text'] = this.nameText;
    data['type_text'] = this.typeText;
    data['Created Date'] = this.createdDate;
    data['Slug'] = this.slug;
    data['Created By'] = this.createdBy;
    data['Modified Date'] = this.modifiedDate;
    data['file1_file'] = this.file1File;
    data['_id'] = this.sId;
    return data;
  }
}
