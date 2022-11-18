class Camera {
  int? id;
  int? addrId;
  int? type;
  int? hubId;
  int? hubType;
  String? serialNumber;
  String? name;
  String? videoSize; // "1920:1080"
  String? lastImage; // local jpg image path
  String? hubName;
  bool? isOnline;
  DateTime? onlineSince;
  DateTime? offlineSince;
  DateTime? dateCreated;
  DateTime? dateUpdated;
}