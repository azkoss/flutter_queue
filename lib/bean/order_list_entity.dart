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
	int payment;
	String id;
	List<OrderListRowsAllmyorder> allMyOrder;
	String cid;

	OrderListRow({this.uid, this.amount, this.createdate, this.payment, this.id, this.allMyOrder, this.cid});

	OrderListRow.fromJson(Map<String, dynamic> json) {
		uid = json['uid'];
		amount = json['amount'];
		createdate = json['createdate'];
		payment = json['payment'];
		id = json['id'];
		if (json['allMyOrder'] != null) {
			allMyOrder = new List<OrderListRowsAllmyorder>();(json['allMyOrder'] as List).forEach((v) { allMyOrder.add(new OrderListRowsAllmyorder.fromJson(v)); });
		}
		cid = json['cid'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['uid'] = this.uid;
		data['amount'] = this.amount;
		data['createdate'] = this.createdate;
		data['payment'] = this.payment;
		data['id'] = this.id;
		if (this.allMyOrder != null) {
      data['allMyOrder'] =  this.allMyOrder.map((v) => v.toJson()).toList();
    }
		data['cid'] = this.cid;
		return data;
	}
}

class OrderListRowsAllmyorder {
	double amount;
	int num;
	String id;
	String did;
	OrderListRowsAllmyorderFood food;
	String cid;

	OrderListRowsAllmyorder({this.amount, this.num, this.id, this.did, this.food, this.cid});

	OrderListRowsAllmyorder.fromJson(Map<String, dynamic> json) {
		amount = json['amount'];
		num = json['num'];
		id = json['id'];
		did = json['did'];
		food = json['food'] != null ? new OrderListRowsAllmyorderFood.fromJson(json['food']) : null;
		cid = json['cid'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['amount'] = this.amount;
		data['num'] = this.num;
		data['id'] = this.id;
		data['did'] = this.did;
		if (this.food != null) {
      data['food'] = this.food.toJson();
    }
		data['cid'] = this.cid;
		return data;
	}
}

class OrderListRowsAllmyorderFood {
	String uid;
	String img;
	String xid;
	double price;
	String name;
	String remark;
	String id;

	OrderListRowsAllmyorderFood({this.uid, this.img, this.xid, this.price, this.name, this.remark, this.id});

	OrderListRowsAllmyorderFood.fromJson(Map<String, dynamic> json) {
		uid = json['uid'];
		img = json['img'];
		xid = json['xid'];
		price = json['price'];
		name = json['name'];
		remark = json['remark'];
		id = json['id'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['uid'] = this.uid;
		data['img'] = this.img;
		data['xid'] = this.xid;
		data['price'] = this.price;
		data['name'] = this.name;
		data['remark'] = this.remark;
		data['id'] = this.id;
		return data;
	}
}
