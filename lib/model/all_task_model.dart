class AllTasksModel {
  int? count;
  List<AllTaskDataModel>? data;

  AllTasksModel({this.count, this.data});

  AllTasksModel.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['data'] != null) {
      data = <AllTaskDataModel>[];
      json['data'].forEach((v) {
        data!.add(new AllTaskDataModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AllTaskDataModel {
  bool? completed;
  String? sId;
  String? title;
  String? description;
  String? dueDate;
  String? owner;
  String? createdAt;
  String? updatedAt;
  int? iV;

  AllTaskDataModel(
      {this.completed,
      this.sId,
      this.title,
      this.description,
      this.dueDate,
      this.owner,
      this.createdAt,
      this.updatedAt,
      this.iV});

  AllTaskDataModel.fromJson(Map<String, dynamic> json) {
    completed = json['completed'];
    sId = json['_id'];
    title = json['title'];
    description = json['description'];
    dueDate = json['dueDate'];
    owner = json['owner'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['completed'] = this.completed;
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['description'] = this.description;
    data['dueDate'] = this.dueDate;
    data['owner'] = this.owner;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}
