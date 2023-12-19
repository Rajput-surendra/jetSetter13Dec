/// message : "Category retrieved successfully"
/// error : false
/// total : 12
/// data : [{"id":"2","name":"Soft Drinks","parent_id":"0","slug":"soft-drinks-1","image":"https://jetsetterindia.com/uploads/media/2023/thumb-sm/18.png","banner":"https://jetsetterindia.com/","row_order":"0","status":"1","clicks":"448","children":[],"text":"Soft Drinks","state":{"opened":true},"icon":"jstree-folder","level":0,"total":12},{"id":"37","name":"Desserts","parent_id":"0","slug":"desserts-1","image":"https://jetsetterindia.com/uploads/media/2023/thumb-sm/61.png","banner":"https://jetsetterindia.com/","row_order":"1","status":"1","clicks":"51","children":[],"text":"Desserts","state":{"opened":true},"icon":"jstree-folder","level":0},{"id":"34","name":"Pizza","parent_id":"0","slug":"pizza-3","image":"https://jetsetterindia.com/uploads/media/2023/thumb-sm/33.png","banner":"https://jetsetterindia.com/","row_order":"2","status":"1","clicks":"21","children":[],"text":"Pizza","state":{"opened":true},"icon":"jstree-folder","level":0},{"id":"40","name":"Tandoori","parent_id":"0","slug":"tandoori-1","image":"https://jetsetterindia.com/uploads/media/2023/thumb-sm/8.png","banner":"https://jetsetterindia.com/","row_order":"4","status":"1","clicks":"2","children":[],"text":"Tandoori","state":{"opened":true},"icon":"jstree-folder","level":0},{"id":"36","name":"Chinese","parent_id":"0","slug":"chinese-1","image":"https://jetsetterindia.com/uploads/media/2023/thumb-sm/51.png","banner":"https://jetsetterindia.com/","row_order":"5","status":"1","clicks":"13","children":[],"text":"Chinese","state":{"opened":true},"icon":"jstree-folder","level":0},{"id":"35","name":"Biryani","parent_id":"0","slug":"biryani","image":"https://jetsetterindia.com/uploads/media/2023/thumb-sm/42.png","banner":"https://jetsetterindia.com/","row_order":"6","status":"1","clicks":"18","children":[],"text":"Biryani","state":{"opened":true},"icon":"jstree-folder","level":0},{"id":"39","name":"Thali","parent_id":"0","slug":"thali-1","image":"https://jetsetterindia.com/uploads/media/2023/thumb-sm/71.png","banner":"https://jetsetterindia.com/","row_order":"7","status":"1","clicks":"46","children":[],"text":"Thali","state":{"opened":true},"icon":"jstree-folder","level":0}]

class SellerByModel {
  SellerByModel({
      String? message, 
      bool? error, 
      num? total, 
      List<Data>? data,}){
    _message = message;
    _error = error;
    _total = total;
    _data = data;
}

  SellerByModel.fromJson(dynamic json) {
    _message = json['message'];
    _error = json['error'];
    _total = json['total'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }
  String? _message;
  bool? _error;
  num? _total;
  List<Data>? _data;
SellerByModel copyWith({  String? message,
  bool? error,
  num? total,
  List<Data>? data,
}) => SellerByModel(  message: message ?? _message,
  error: error ?? _error,
  total: total ?? _total,
  data: data ?? _data,
);
  String? get message => _message;
  bool? get error => _error;
  num? get total => _total;
  List<Data>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = _message;
    map['error'] = _error;
    map['total'] = _total;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : "2"
/// name : "Soft Drinks"
/// parent_id : "0"
/// slug : "soft-drinks-1"
/// image : "https://jetsetterindia.com/uploads/media/2023/thumb-sm/18.png"
/// banner : "https://jetsetterindia.com/"
/// row_order : "0"
/// status : "1"
/// clicks : "448"
/// children : []
/// text : "Soft Drinks"
/// state : {"opened":true}
/// icon : "jstree-folder"
/// level : 0
/// total : 12

class Data {
  Data({
      String? id, 
      String? name, 
      String? parentId, 
      String? slug, 
      String? image, 
      String? banner, 
      String? rowOrder, 
      String? status, 
      String? clicks, 
      List<dynamic>? children, 
      String? text, 
      State1? state,
      String? icon, 
      num? level, 
      num? total,}){
    _id = id;
    _name = name;
    _parentId = parentId;
    _slug = slug;
    _image = image;
    _banner = banner;
    _rowOrder = rowOrder;
    _status = status;
    _clicks = clicks;
    _children = children;
    _text = text;
    _state = state;
    _icon = icon;
    _level = level;
    _total = total;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _parentId = json['parent_id'];
    _slug = json['slug'];
    _image = json['image'];
    _banner = json['banner'];
    _rowOrder = json['row_order'];
    _status = json['status'];
    _clicks = json['clicks'];
    if (json['children'] != null) {
      _children = [];
      json['children'].forEach((v) {
        _children?.add(v.fromJson(v));
      });
    }
    _text = json['text'];
    _state = json['state'] != null ? State1.fromJson(json['state']) : null;
    _icon = json['icon'];
    _level = json['level'];
    _total = json['total'];
  }
  String? _id;
  String? _name;
  String? _parentId;
  String? _slug;
  String? _image;
  String? _banner;
  String? _rowOrder;
  String? _status;
  String? _clicks;
  List<dynamic>? _children;
  String? _text;
  State1? _state;
  String? _icon;
  num? _level;
  num? _total;
Data copyWith({  String? id,
  String? name,
  String? parentId,
  String? slug,
  String? image,
  String? banner,
  String? rowOrder,
  String? status,
  String? clicks,
  List<dynamic>? children,
  String? text,
  State1? state,
  String? icon,
  num? level,
  num? total,
}) => Data(  id: id ?? _id,
  name: name ?? _name,
  parentId: parentId ?? _parentId,
  slug: slug ?? _slug,
  image: image ?? _image,
  banner: banner ?? _banner,
  rowOrder: rowOrder ?? _rowOrder,
  status: status ?? _status,
  clicks: clicks ?? _clicks,
  children: children ?? _children,
  text: text ?? _text,
  state: state ?? _state,
  icon: icon ?? _icon,
  level: level ?? _level,
  total: total ?? _total,
);
  String? get id => _id;
  String? get name => _name;
  String? get parentId => _parentId;
  String? get slug => _slug;
  String? get image => _image;
  String? get banner => _banner;
  String? get rowOrder => _rowOrder;
  String? get status => _status;
  String? get clicks => _clicks;
  List<dynamic>? get children => _children;
  String? get text => _text;
  State1? get state => _state;
  String? get icon => _icon;
  num? get level => _level;
  num? get total => _total;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['parent_id'] = _parentId;
    map['slug'] = _slug;
    map['image'] = _image;
    map['banner'] = _banner;
    map['row_order'] = _rowOrder;
    map['status'] = _status;
    map['clicks'] = _clicks;
    if (_children != null) {
      map['children'] = _children?.map((v) => v.toJson()).toList();
    }
    map['text'] = _text;
    if (_state != null) {
      map['state'] = _state?.toJson();
    }
    map['icon'] = _icon;
    map['level'] = _level;
    map['total'] = _total;
    return map;
  }

}

/// opened : true

class State1 {
  State1({
      bool? opened,}){
    _opened = opened;
}

  State1.fromJson(dynamic json) {
    _opened = json['opened'];
  }
  bool? _opened;
State1 copyWith({  bool? opened,
}) => State1(  opened: opened ?? _opened,
);
  bool? get opened => _opened;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['opened'] = _opened;
    return map;
  }

}