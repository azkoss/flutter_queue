//公用返回值实体类
class ResultEntity {
  String msg;
  bool success;
  String rows;

  ResultEntity({this.msg, this.success, this.rows});

  ResultEntity.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    success = json['success'];
    rows = json['rows'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msg'] = this.msg;
    data['success'] = this.success;
    if (this.rows != null) {
      data['rows'] = this.rows;
    }
    return data;
  }
}