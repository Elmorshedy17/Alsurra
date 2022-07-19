class FamilyCartRequest {
  String? cardId;
  FamilyCartRequest({this.cardId,});
  FamilyCartRequest.fromJson(Map<String, dynamic> json) {
    cardId = json['card_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['card_id'] = cardId;
    return data;
  }
}

