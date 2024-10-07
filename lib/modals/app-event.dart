class AppEvent {
  String? type;
  String? eventName;
  String? startTime;
  String? endtime;
  String? eventLocation;
  String? description;

  AppEvent(
      {this.type,
      this.eventName,
      this.startTime,
      this.endtime,
      this.eventLocation,
      this.description});
}
