class Booking {
  Booking({
    this.id,
    this.userId,
    this.destinationLocation,
    this.arrivalLocation,
    this.date,
    this.time,
    this.isAdmin,
    this.price,
    this.status,
    this.comment,
    this.securityGuard,
    this.acceptReject,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  int userId;
  String destinationLocation;
  String arrivalLocation;
  DateTime date;
  String time;
  int isAdmin;
  int price;
  int status;
  String comment;
  int securityGuard;
  int acceptReject;
  DateTime createdAt;
  DateTime updatedAt;

  factory Booking.fromJson(Map<String, dynamic> json) => Booking(
    id: json["id"],
    userId: json["user_id"],
    destinationLocation: json["destination_location"],
    arrivalLocation: json["arrival_location"],
    date: DateTime.parse(json["date"]),
    time: json["time"],
    isAdmin: json["is_admin"],
    price: json["price"],
    status: json["status"],
    comment: json["comment"],
    securityGuard: json["security_guard"],
    acceptReject: json["accept_reject"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "destination_location": destinationLocation,
    "arrival_location": arrivalLocation,
    "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
    "time": time,
    "is_admin": isAdmin,
    "price": price,
    "status": status,
    "comment": comment,
    "security_guard": securityGuard,
    "accept_reject": acceptReject,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}