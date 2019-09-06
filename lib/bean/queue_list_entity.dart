//排队列表实体类
class QueueListEntity {
	String msg;
	bool success;
	List<QueueListRow> rows;

	QueueListEntity({this.msg, this.success, this.rows});

	QueueListEntity.fromJson(Map<String, dynamic> json) {
		msg = json['msg'];
		success = json['success'];
		if (json['rows'] != null) {
			rows = new List<QueueListRow>();(json['rows'] as List).forEach((v) { rows.add(new QueueListRow.fromJson(v)); });
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

class QueueListRow {
	String zid;
	String name;
	int progress;
	int createdate;
	String id;
	String sid;

	QueueListRow({this.zid, this.name, this.progress, this.createdate, this.id, this.sid});

	QueueListRow.fromJson(Map<String, dynamic> json) {
		zid = json['zid'];
		name = json['name'];
		progress = json['progress'];
		createdate = json['createdate'];
		id = json['id'];
		sid = json['sid'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['zid'] = this.zid;
		data['name'] = this.name;
		data['progress'] = this.progress;
		data['createdate'] = this.createdate;
		data['id'] = this.id;
		data['sid'] = this.sid;
		return data;
	}
}
