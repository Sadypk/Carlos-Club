class GroupModel{
  String groupName;
  List<String> members;
  String theme;

  GroupModel({
    this.groupName,
    this.theme,
    this.members
  });

  Map<String, dynamic> toJson(){
    var data = {
      "groupName" : groupName??'',
      "theme": theme??'',
      "members": members??[],

    };
    return data;
  }

  GroupModel.fromJson(Map<String, dynamic> json){
    groupName = json['groupName'];
    theme = json['theme'];

    if(json['members']!=null){
      members = List<String>();
      json['members'].forEach((v){
        members.add(v);
      });
    }
  }
}