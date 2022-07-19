class ProfitsRequest {
  String? cardId;
  ProfitsRequest({this.cardId,});
  ProfitsRequest.fromJson(Map<String, dynamic> json) {
    cardId = json['card_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['card_id'] = cardId;
    return data;
  }
}

