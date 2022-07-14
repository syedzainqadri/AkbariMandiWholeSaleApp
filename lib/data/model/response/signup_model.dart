class SignUpModel {
  String fName;
  String lName;
  String email;
  String phone;
  String password;
  String cnic;

  SignUpModel({
    this.fName,
    this.lName,
    this.email,
    this.phone,
    this.password,
    this.cnic,
  });

  SignUpModel.fromJson(Map<String, dynamic> json) {
    fName = json['f_name'];
    lName = json['l_name'];
    email = json['email'];
    phone = json['phone'];
    password = json['password'];
    cnic = json['cnic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['f_name'] = this.fName;
    data['l_name'] = this.lName;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['password'] = this.password;
    data['cnic'] = this.cnic;
    return data;
  }
}
