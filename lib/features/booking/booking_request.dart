class BookingRequest {
  int? id;
  String? type;
  String? date;
  String? time;
  int? count;
  String? cardId;
  int? optionId;

  BookingRequest(
      {this.id,
      this.type,
      this.date,
      this.time,
      this.count,
      this.cardId,
      this.optionId});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['type'] = type;
    data['date'] = date;
    data['time'] = time;
    data['count'] = count;
    data['card_id'] = cardId;
    data['option_id'] = optionId;
    return data;
  }
}

enum BookingType {
  activity,
  discount,
  course,
  hotel,
  playground,
}
