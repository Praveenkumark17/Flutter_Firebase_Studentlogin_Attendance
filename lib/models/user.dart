// class Preuser {
//   final bool id;
//   Preuser({this.id=true});
// }

class UserID {
  final String uid;
  final bool puid;
  UserID({required this.uid, required this.puid});
}

class Users {
  final String firstname;
  final String lastname;
  final String register;
  final String mobile;
  final String gender;
  // final String othergender;
  final String email;
  final String password;
  final String dob;
  final String imagepath;
  final String imageURL;

  Users(this.firstname, this.lastname, this.register, this.mobile, this.gender,
      this.email, this.password, this.dob, this.imagepath, this.imageURL);
  Map<String, dynamic> toMap() {
    return {
      'firstName': firstname,
      'lastName': lastname,
      'register_no': register,
      'mobile_no': mobile,
      'email': email,
      'password': password,
      // if (gender == 'others') 'gender': othergender else 'gender': gender,
      'gender': gender,
      'dob': dob,
      'imagepath': imagepath,
      'imageURL' : imageURL,
    };
  }
}
