class Booking {
  Booking({
    this.id,
    this.location,
    this.userId,
    this.counting,
    this.fromTime,
    this.toTime,
    this.fromDate,
    this.toDate,
    this.status,
    this.comment,
    this.selectDays,
    this.createdAt,
    this.updatedAt,
    this.destinationLocation,
    this.arrivalLocation,
    this.date,
    this.time,
    this.isAdmin,
    this.price,
    this.securityGuard,
    this.acceptReject,
    this.userType
  });

  int id;
  String location;
  int userId;
  String counting;
  String fromTime;
  String toTime;
  DateTime fromDate;
  DateTime toDate;
  int status;
  String comment;
  List<String> selectDays;
  DateTime createdAt;
  DateTime updatedAt;
  String destinationLocation;
  String arrivalLocation;
  DateTime date;
  String time;
  String userType;
  int isAdmin;
  int price;
  int securityGuard;
  int acceptReject;

  factory Booking.fromJson(Map<String, dynamic> json) => Booking(
    id: json["id"],
    location: json["location"] == null ? null : json["location"],
    userId: json["user_id"],
    counting: json["counting"] == null ? null : json["counting"],
    fromTime: json["from_time"] == null ? null : json["from_time"],
    userType: json["user_type"] == null ? null : json["user_typ"],
    toTime: json["to_time"] == null ? null : json["to_time"],
    fromDate: json["from_date"] == null ? null : DateTime.parse(json["from_date"]),
    toDate: json["to_date"] == null ? null : DateTime.parse(json["to_date"]),
    status: json["status"],
    comment: json["comment"] == null ? null : json["comment"],
    selectDays: json["select_days"] == null ? null : List<String>.from(json["select_days"].map((x) => x)),
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    destinationLocation: json["destination_location"] == null ? null : json["destination_location"],
    arrivalLocation: json["arrival_location"] == null ? null : json["arrival_location"],
    date: json["date"] == null ? null : DateTime.parse(json["date"]),

    time: json["time"] == null ? null : json["time"],
    isAdmin: json["is_admin"] == null ? null : json["is_admin"],
    price: json["price"] == null ? null : json["price"],
    securityGuard: json["security_guard"] == null ? null : json["security_guard"],
    acceptReject: json["accept_reject"] == null ? null : json["accept_reject"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "location": location == null ? null : location,
    "user_id": userId,
    "counting": counting == null ? null : counting,
    "from_time": fromTime == null ? null : fromTime,
    "user_type": userType == null ? null : userType,
    "to_time": toTime == null ? null : toTime,
    "from_date": fromDate == null ? null : "${fromDate.year.toString().padLeft(4, '0')}-${fromDate.month.toString().padLeft(2, '0')}-${fromDate.day.toString().padLeft(2, '0')}",
    "to_date": toDate == null ? null : "${toDate.year.toString().padLeft(4, '0')}-${toDate.month.toString().padLeft(2, '0')}-${toDate.day.toString().padLeft(2, '0')}",
    "status": status,
    "comment": comment == null ? null : comment,
    "select_days": selectDays == null ? null : List<dynamic>.from(selectDays.map((x) => x)),
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "destination_location": destinationLocation == null ? null : destinationLocation,
    "arrival_location": arrivalLocation == null ? null : arrivalLocation,
    "date": date == null ? null : "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
    "time": time == null ? null : time,
    "is_admin": isAdmin == null ? null : isAdmin,
    "price": price == null ? null : price,
    "security_guard": securityGuard == null ? null : securityGuard,
    "accept_reject": acceptReject == null ? null : acceptReject,
  };
}