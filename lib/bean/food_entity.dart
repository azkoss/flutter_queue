class FoodEntity {
	String msg;
	bool success;
	List<FoodRow> rows;

	FoodEntity({this.msg, this.success, this.rows});

	FoodEntity.fromJson(Map<String, dynamic> json) {
		msg = json['msg'];
		success = json['success'];
		if (json['rows'] != null) {
			rows = new List<FoodRow>();(json['rows'] as List).forEach((v) { rows.add(new FoodRow.fromJson(v)); });
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

class FoodRow {
	String uid;
	String img;
	String xid;
	double price;
	String name;
	String remark;
	String id;

	FoodRow({this.uid, this.img, this.xid, this.price, this.name, this.remark, this.id});

	FoodRow.fromJson(Map<String, dynamic> json) {
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
