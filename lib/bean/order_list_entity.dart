///订单列表实体类
class OrderListEntity {
	String msg;
	bool success;
	List<OrderListRow> rows;

	OrderListEntity({this.msg, this.success, this.rows});

	OrderListEntity.fromJson(Map<String, dynamic> json) {
		msg = json['msg'];
		success = json['success'];
		if (json['rows'] != null) {
			rows = new List<OrderListRow>();(json['rows'] as List).forEach((v) { rows.add(new OrderListRow.fromJson(v)); });
		}
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['msg'] = this.msg;
		data['success'] = this.success;
		if (this.rows != null) {
      data['rows'] =  this.rows.map((v) => v.toJson()).toList();
    }
		return data;
	}
}

class OrderListRow {
	String uid;
	double amount;
	String createdate;
	String id;
	String cid;

	OrderListRow({this.uid, this.amount, this.createdate, this.id, this.cid});

	OrderListRow.fromJson(Map<String, dynamic> json) {
		uid = json['uid'];
		amount = json['amount'];
		createdate = json['createdate'];
		id = json['id'];
		cid = json['cid'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['uid'] = this.uid;
		data['amount'] = this.amount;
		data['createdate'] = this.createdate;
		data['id'] = this.id;
		data['cid'] = this.cid;
		return data;
	}
}
