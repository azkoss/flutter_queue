//商家实体类
class MerchantEntity {
	String msg;
	bool success;
	List<MerchantRow> rows;

	MerchantEntity({this.msg, this.success, this.rows});

	MerchantEntity.fromJson(Map<String, dynamic> json) {
		msg = json['msg'];
		success = json['success'];
		if (json['rows'] != null) {
			rows = new List<MerchantRow>();(json['rows'] as List).forEach((v) { rows.add(new MerchantRow.fromJson(v)); });
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

class MerchantRow {
	String password;
	String phone;
	String name;
	int merchant;
	String id;
	String heads;
	String account;
	String gender;

	MerchantRow({this.password, this.phone, this.name, this.merchant, this.id, this.heads, this.account, this.gender});

	MerchantRow.fromJson(Map<String, dynamic> json) {
		password = json['password'];
		phone = json['phone'];
		name = json['name'];
		merchant = json['merchant'];
		id = json['id'];
		heads = json['heads'];
		account = json['account'];
		gender = json['gender'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['password'] = this.password;
		data['phone'] = this.phone;
		data['name'] = this.name;
		data['merchant'] = this.merchant;
		data['id'] = this.id;
		data['heads'] = this.heads;
		data['account'] = this.account;
		data['gender'] = this.gender;
		return data;
	}

	@override
	String toString() {
		return 'MerchantRow{password: $password, phone: $phone, name: $name, merchant: $merchant, id: $id, heads: $heads, account: $account, gender: $gender}';
	}


}
