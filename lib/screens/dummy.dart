class Example {
  Meta? meta;
  List<Data>? data;

  Example({this.meta, this.data});

  Example.fromJson(Map<String, dynamic> json) {
    this.meta = json["meta"] == null ? null : Meta.fromJson(json["meta"]);
    this.data = json["data"] == null
        ? null
        : (json["data"] as List).map((e) => Data.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.meta != null) data["meta"] = this.meta?.toJson();
    if (this.data != null)
      data["data"] = this.data?.map((e) => e.toJson()).toList();
    return data;
  }
}

class Data {
  int? id;
  int? userId;
  String? title;
  String? dueOn;
  String? status;

  Data({this.id, this.userId, this.title, this.dueOn, this.status});

  Data.fromJson(Map<String, dynamic> json) {
    this.id = json["id"];
    this.userId = json["user_id"];
    this.title = json["title"];
    this.dueOn = json["due_on"];
    this.status = json["status"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = this.id;
    data["user_id"] = this.userId;
    data["title"] = this.title;
    data["due_on"] = this.dueOn;
    data["status"] = this.status;
    return data;
  }
}

class Meta {
  Pagination? pagination;

  Meta({this.pagination});

  Meta.fromJson(Map<String, dynamic> json) {
    this.pagination = json["pagination"] == null
        ? null
        : Pagination.fromJson(json["pagination"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.pagination != null) data["pagination"] = this.pagination?.toJson();
    return data;
  }
}

class Pagination {
  int? total;
  int? pages;
  int? page;
  int? limit;
  Links? links;

  Pagination({this.total, this.pages, this.page, this.limit, this.links});

  Pagination.fromJson(Map<String, dynamic> json) {
    this.total = json["total"];
    this.pages = json["pages"];
    this.page = json["page"];
    this.limit = json["limit"];
    this.links = json["links"] == null ? null : Links.fromJson(json["links"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["total"] = this.total;
    data["pages"] = this.pages;
    data["page"] = this.page;
    data["limit"] = this.limit;
    if (this.links != null) data["links"] = this.links?.toJson();
    return data;
  }
}

class Links {
  dynamic? previous;
  String? current;
  String? next;

  Links({this.previous, this.current, this.next});

  Links.fromJson(Map<String, dynamic> json) {
    this.previous = json["previous"];
    this.current = json["current"];
    this.next = json["next"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["previous"] = this.previous;
    data["current"] = this.current;
    data["next"] = this.next;
    return data;
  }
}
