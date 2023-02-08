class Users {

  String? userName;
  String email;
  String password;

  String? confirmPassword;


  Users({required this.email, required this.password, this.userName, this.confirmPassword});

}