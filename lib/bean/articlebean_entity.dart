//学生端语法文章列表
class ArticlebeanEntity {
	int code;
	ArticlebeanData data;
	bool success;
	String message;

	ArticlebeanEntity({this.code, this.data, this.success, this.message});

	ArticlebeanEntity.fromJson(Map<String, dynamic> json) {
		code = json['code'];
		data = json['data'] != null ? new ArticlebeanData.fromJson(json['data']) : null;
		success = json['success'];
		message = json['message'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['code'] = this.code;
		if (this.data != null) {
      data['data'] = this.data.toJson();
    }
		data['success'] = this.success;
		data['message'] = this.message;
		return data;
	}
}

class ArticlebeanData {
	String count;
	List<ArticlebeanDataList> xList;

	ArticlebeanData({this.count, this.xList});

	ArticlebeanData.fromJson(Map<String, dynamic> json) {
		count = json['count'];
		if (json['list'] != null) {
			xList = new List<ArticlebeanDataList>();(json['list'] as List).forEach((v) { xList.add(new ArticlebeanDataList.fromJson(v)); });
		}
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['count'] = this.count;
		if (this.xList != null) {
      data['list'] =  this.xList.map((v) => v.toJson()).toList();
    }
		return data;
	}
}

class ArticlebeanDataList {
	int questionCount;
	String pcImageUrl;
	String createTime;
	String description;
	String titleImageUrl;
	String id;
	String title;
	bool isDone;
	String questionType;
	String content;

	ArticlebeanDataList({this.questionCount, this.pcImageUrl, this.createTime, this.description, this.titleImageUrl, this.id, this.title, this.isDone, this.questionType, this.content});

	ArticlebeanDataList.fromJson(Map<String, dynamic> json) {
		questionCount = json['questionCount'];
		pcImageUrl = json['pcImageUrl'];
		createTime = json['createTime'];
		description = json['description'];
		titleImageUrl = json['titleImageUrl'];
		id = json['id'];
		title = json['title'];
		isDone = json['isDone'];
		questionType = json['questionType'];
		content = json['content'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['questionCount'] = this.questionCount;
		data['pcImageUrl'] = this.pcImageUrl;
		data['createTime'] = this.createTime;
		data['description'] = this.description;
		data['titleImageUrl'] = this.titleImageUrl;
		data['id'] = this.id;
		data['title'] = this.title;
		data['isDone'] = this.isDone;
		data['questionType'] = this.questionType;
		data['content'] = this.content;
		return data;
	}
}
