class Profile {
  String name;
  String lastName;
  String gender;
  String email;

  Profile(String mName, String mLastName, String mGender, String mEmail)
      : name = mName,
        lastName = mLastName,
        gender = mGender,
        email = mEmail;

  // Profile(this.name, this.lastName, this.gender, this.email);
}
