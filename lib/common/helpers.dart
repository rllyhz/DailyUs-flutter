bool validateEmailFormat(String email) => RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
    .hasMatch(email);

bool validatePasswordFormat(String password) => password.length >= 6;

String getFirstName(String name) => name.split(" ").first;
