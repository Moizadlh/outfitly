import 'dart:ffi';

class UsersModel{
  int? UserId;
  String? FullName;
  String? Phone;
  String? Email;
  String? Address;
  String? BirthDate;
  String? LoginPassword;

  UsersModel({this.UserId, this.FullName, this.Phone, this.Email,
      this.Address, this.LoginPassword});

  UsersModel.fromMap(Map<String,dynamic> res)
      : UserId = res ['UserId'],
        FullName = res['FullName'],
        Phone = res ['Phone'],
        Email = res ['Email'],
        Address = res['Address'],
        BirthDate = res ['BirthDate'],
        LoginPassword = res ['LoginPassword'];


  Map<String,Object?> toMap(){
    return {
      "UserId" : UserId,
      "FullName" : FullName,
      "Phone" : Phone,
      "Email" : Email,
      "Address" : Address,
      "BirthDate" : BirthDate,
      "LoginPassword" : LoginPassword,
    };
  }

  @override
  String toString() {
    return 'UsersModel{UserId: $UserId, FullName: $FullName, Phone: $Phone, Email: $Email, Address: $Address, BirthDate: $BirthDate, LoginPassword: $LoginPassword}';
  }
}