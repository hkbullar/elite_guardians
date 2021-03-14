class DaysListModel {
  int dayId;
  String img;
  String title;
  bool isCheck;

  DaysListModel({this.dayId, this.img, this.title, this.isCheck});

  static List<DaysListModel> getDays() {
    return <DaysListModel>[
      DaysListModel(
          dayId: 1,
          title: "Sun",
          isCheck: true),
      DaysListModel(
          dayId: 2,
          title: "Mon",
          isCheck: false),
      DaysListModel(
          dayId: 3,
          title: "Tue",
          isCheck: false),
      DaysListModel(
          dayId: 4,
          title: "Wed",
          isCheck: false),
      DaysListModel(
          dayId: 5,
          title: "Thu",
          isCheck: false),
      DaysListModel(
          dayId: 6,
          title: "Fri",
          isCheck: false),
      DaysListModel(
          dayId: 7,
          title: "Sat",
          isCheck: false),
    ];
  }

}
