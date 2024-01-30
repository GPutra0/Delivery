class Provinsi {
  String? provinceid;
  String? province;

  Provinsi({this.provinceid, this.province});
  Provinsi.fromJson(Map<String, dynamic> json) {
    provinceid = json['province_id'];
    province = json['province'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['province_id'] = provinceid;
    data['province'] = province;
    return data;
  }

  static List<Provinsi> fromJsonList(List list) {
    if (list.length == Null) return List<Provinsi>.empty();
    return list.map((item) => Provinsi.fromJson(item)).toList();
  }
}
