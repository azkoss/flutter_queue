//菜系实体类
class FoodTypeEntity {
	String msg;
	bool success;
	List<FoodTypeRow> rows;

	FoodTypeEntity({this.msg, this.success, this.rows});

	FoodTypeEntity.fromJson(Map<String, dynamic> json) {
		msg = json['msg'];
		success = json['success'];
		if (json['rows'] != null) {
			rows = new List<FoodTypeRow>();(json['rows'] as List).forEach((v) { rows.add(new FoodTypeRow.fromJson(v)); });
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

class FoodTypeRow {
	String name;
	String id;

	FoodTypeRow({this.name, this.id});

	FoodTypeRow.fromJson(Map<String, dynamic> json) {
		name = json['name'];
		id = json['id'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['name'] = this.name;
		data['id'] = this.id;
		return data;
	}

	@override
	String toString() {
		return 'FoodTypeRow{name: $name, id: $id}';
	}


}
