class Booking {
  Booking({
    this.id,
    this.location,
    this.locationLat,
    this.locationLong,
    this.userId,
    this.bookNowOrLater,
    this.counting,
    this.fromTime,
    this.userType,
    this.toTime,
    this.fromDate,
    this.toDate,
    this.price,
    this.status,
    this.comment,
    this.latitude,
    this.longitude,
    this.selectDays,
    this.createdAt,
    this.updatedAt,
    this.user,
    this.guardians,
    this.startGuradianBooking,
    this.destinationLocation,
    this.arrivalLocation,
    this.destinationLat,
    this.destinationLong,
    this.arrivalLat,
    this.arrivalLong,
    this.date,
    this.time,
    this.isAdmin,
    this.securityGuard,
    this.acceptReject,
    this.drivers,
    this.startBooking,
  });

  int id;
  String location;
  String locationLat;
  String locationLong;
  int userId;
  int bookNowOrLater;
  String counting;
  String fromTime;
  String userType;
  String toTime;
  DateTime fromDate;
  DateTime toDate;
  int price;
  int status;
  String comment;
  dynamic latitude;
  dynamic longitude;
  List<String> selectDays;
  DateTime createdAt;
  DateTime updatedAt;
  User user;
  List<Guardian> guardians;
  List<dynamic> startGuradianBooking;
  String destinationLocation;
  String arrivalLocation;
  String destinationLat;
  String destinationLong;
  String arrivalLat;
  String arrivalLong;
  DateTime date;
  String time;
  int isAdmin;
  int securityGuard;
  int acceptReject;
  List<Driver> drivers;
  List<dynamic> startBooking;

  factory Booking.fromJson(Map<String, dynamic> json) => Booking(
    id: json["id"],
    location: json["location"] == null ? null : json["location"],
    locationLat: json["location_lat"] == null ? null : json["location_lat"],
    locationLong: json["location_long"] == null ? null : json["location_long"],
    userId: json["user_id"],
    bookNowOrLater: json["book_now_or_later"],
    counting: json["counting"] == null ? null : json["counting"],
    fromTime: json["from_time"] == null ? null : json["from_time"],
    userType: json["user_type"] == null ? null : json["user_type"],
    toTime: json["to_time"] == null ? null : json["to_time"],
    fromDate: json["from_date"] == null ? null : DateTime.parse(json["from_date"]),
    toDate: json["to_date"] == null ? null : DateTime.parse(json["to_date"]),
    price: json["price"],
    status: json["status"],
    comment: json["comment"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    selectDays: json["select_days"] == null ? null : List<String>.from(json["select_days"].map((x) => x)),
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    user: User.fromJson(json["user"]),
    guardians: json["guardians"] == null ? null : List<Guardian>.from(json["guardians"].map((x) => Guardian.fromJson(x))),
    startGuradianBooking: json["start_guradian_booking"] == null ? null : List<dynamic>.from(json["start_guradian_booking"].map((x) => x)),
    destinationLocation: json["destination_location"] == null ? null : json["destination_location"],
    arrivalLocation: json["arrival_location"] == null ? null : json["arrival_location"],
    destinationLat: json["destination_lat"] == null ? null : json["destination_lat"],
    destinationLong: json["destination_long"] == null ? null : json["destination_long"],
    arrivalLat: json["arrival_lat"] == null ? null : json["arrival_lat"],
    arrivalLong: json["arrival_long"] == null ? null : json["arrival_long"],
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    time: json["time"] == null ? null : json["time"],
    isAdmin: json["is_admin"] == null ? null : json["is_admin"],
    securityGuard: json["security_guard"] == null ? null : json["security_guard"],
    acceptReject: json["accept_reject"] == null ? null : json["accept_reject"],
    drivers: json["drivers"] == null ? null : List<Driver>.from(json["drivers"].map((x) => Driver.fromJson(x))),
    startBooking: json["start_booking"] == null ? null : List<dynamic>.from(json["start_booking"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "location": location == null ? null : location,
    "location_lat": locationLat == null ? null : locationLat,
    "location_long": locationLong == null ? null : locationLong,
    "user_id": userId,
    "book_now_or_later": bookNowOrLater,
    "counting": counting == null ? null : counting,
    "from_time": fromTime == null ? null : fromTime,
    "user_type": userType == null ? null : userType,
    "to_time": toTime == null ? null : toTime,
    "from_date": fromDate == null ? null : "${fromDate.year.toString().padLeft(4, '0')}-${fromDate.month.toString().padLeft(2, '0')}-${fromDate.day.toString().padLeft(2, '0')}",
    "to_date": toDate == null ? null : "${toDate.year.toString().padLeft(4, '0')}-${toDate.month.toString().padLeft(2, '0')}-${toDate.day.toString().padLeft(2, '0')}",
    "price": price,
    "status": status,
    "comment": comment,
    "latitude": latitude,
    "longitude": longitude,
    "select_days": selectDays == null ? null : List<dynamic>.from(selectDays.map((x) => x)),
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "user": user.toJson(),
    "guardians": guardians == null ? null : List<dynamic>.from(guardians.map((x) => x.toJson())),
    "start_guradian_booking": startGuradianBooking == null ? null : List<dynamic>.from(startGuradianBooking.map((x) => x)),
    "destination_location": destinationLocation == null ? null : destinationLocation,
    "arrival_location": arrivalLocation == null ? null : arrivalLocation,
    "destination_lat": destinationLat == null ? null : destinationLat,
    "destination_long": destinationLong == null ? null : destinationLong,
    "arrival_lat": arrivalLat == null ? null : arrivalLat,
    "arrival_long": arrivalLong == null ? null : arrivalLong,
    "date": date == null ? null : "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
    "time": time == null ? null : time,
    "is_admin": isAdmin == null ? null : isAdmin,
    "security_guard": securityGuard == null ? null : securityGuard,
    "accept_reject": acceptReject == null ? null : acceptReject,
    "drivers": drivers == null ? null : List<dynamic>.from(drivers.map((x) => x.toJson())),
    "start_booking": startBooking == null ? null : List<dynamic>.from(startBooking.map((x) => x)),
  };
}

class Driver {
  Driver({
    this.id,
    this.bookingId,
    this.driverId,
    this.status,
    this.startJob,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  int bookingId;
  int driverId;
  int status;
  int startJob;
  DateTime createdAt;
  DateTime updatedAt;

  factory Driver.fromJson(Map<String, dynamic> json) => Driver(
    id: json["id"],
    bookingId: json["booking_id"],
    driverId: json["driver_id"],
    status: json["status"],
    startJob: json["start_job"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "booking_id": bookingId,
    "driver_id": driverId,
    "status": status,
    "start_job": startJob,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}

class Guardian {
  Guardian({
    this.id,
    this.bookingId,
    this.guardId,
    this.status,
    this.startJob,
    this.startAt,
    this.endAt,
    this.totalHour,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  int bookingId;
  int guardId;
  int status;
  int startJob;
  DateTime startAt;
  DateTime endAt;
  int totalHour;
  DateTime createdAt;
  DateTime updatedAt;

  factory Guardian.fromJson(Map<String, dynamic> json) => Guardian(
    id: json["id"],
    bookingId: json["booking_id"],
    guardId: json["guard_id"],
    status: json["status"],
    startJob: json["start_job"],
    startAt: DateTime.parse(json["start_at"]),
    endAt: DateTime.parse(json["end_at"]),
    totalHour: json["total_hour"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "booking_id": bookingId,
    "guard_id": guardId,
    "status": status,
    "start_job": startJob,
    "start_at": startAt.toIso8601String(),
    "end_at": endAt.toIso8601String(),
    "total_hour": totalHour,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}

class User {
  User({
    this.id,
    this.name,
    this.email,
    this.phoneNo,
    this.image,
    this.gender,
    this.emailVerifiedAt,
    this.onlineOffline,
    this.lat,
    this.long,
    this.userSubType,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String name;
  String email;
  dynamic phoneNo;
  String image;
  dynamic gender;
  dynamic emailVerifiedAt;
  dynamic onlineOffline;
  String lat;
  dynamic long;
  dynamic userSubType;
  DateTime createdAt;
  DateTime updatedAt;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    phoneNo: json["phone_no"],
    image: json["image"],
    gender: json["gender"],
    emailVerifiedAt: json["email_verified_at"],
    onlineOffline: json["online_offline"],
    lat: json["lat"],
    long: json["long"],
    userSubType: json["user_sub_type"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "phone_no": phoneNo,
    "image": image,
    "gender": gender,
    "email_verified_at": emailVerifiedAt,
    "online_offline": onlineOffline,
    "lat": lat,
    "long": long,
    "user_sub_type": userSubType,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
