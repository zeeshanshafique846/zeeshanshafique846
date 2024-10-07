class AppContact {
  String? type;
  String? firstName;
  String? lastName;
  String? company;
  String? job;
  String? phone;
  String? email;
  String? address;
  String? city;
  String? country;

  AppContact(
      {this.type,
      this.firstName,
      this.lastName,
      this.company,
      this.job,
      this.phone,
      this.email,
      this.address,
      this.city,
      this.country});

  void display() {
    print('$firstName');
  }
  //controntor
  //from string -> AppContact
  //to-String -> String
}
