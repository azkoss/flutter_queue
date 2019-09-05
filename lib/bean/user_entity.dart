class UserEntity {
	String msg;
	bool success;
	UserRows rows;

	UserEntity({this.msg, this.success, this.rows});

	UserEntity.fromJson(Map<String, dynamic> json) {
		msg = json['msg'];
		success = json['success'];
		rows = json['rows'] != null ? new UserRows.fromJson(json['rows']) : null;
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['msg'] = this.msg;
		data['success'] = this.success;
		if (this.rows != null) {
      data['rows'] = this.rows.toJson();
    }
		return data;
	}
}

class UserRows {
	String password;
	String gender;
	String phone;
	String name;
	int merchant;
	String id;
	String heads;
	String account;

	UserRows({this.password, this.gender, this.phone, this.name, this.merchant, this.id, this.heads, this.account});

	UserRows.fromJson(Map<String, dynamic> json) {
		password = json['password'];
		gender = json['gender'];
		phone = json['phone'];
		name = json['name'];
		merchant = json['merchant'];
		id = json['id'];
		heads = json['heads'];
		account = json['account'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['password'] = this.password;
		data['gender'] = this.gender;
		data['phone'] = this.phone;
		data['name'] = this.name;
		data['merchant'] = this.merchant;
		data['id'] = this.id;
		data['heads'] = this.heads;
		data['account'] = this.account;
		return data;
	}
}
