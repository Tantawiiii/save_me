//
//
//
// final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
// final TextEditingController _nameController = TextEditingController();
// final TextEditingController _usernameController = TextEditingController();
// final TextEditingController _emailController = TextEditingController();
// final TextEditingController _passwordController = TextEditingController();
// final TextEditingController _phoneNumController = TextEditingController();
// final TextEditingController _confirmPasswordController =
// TextEditingController();
// final TextEditingController _locationController = TextEditingController();
//
// // Initialize Dio with ApiClient
// final ApiClient _apiClient = ApiClient();
// Future<void> _registerUserFun() async {
//   // to implement a register
//   if (_formKey.currentState!.validate()) {
//     String name = _nameController.text;
//     String username = _usernameController.text;
//     String email = _emailController.text;
//     String password = _passwordController.text;
//     String phoneNumber = _phoneNumController.text;
//     String location = _locationController.text;
//
//     if (kDebugMode) {
//       print('Name: $name');
//       print('Username: $username');
//       print('Email: $email');
//       print('Password: $password');
//       print('PhoneNumber: $phoneNumber');
//       print('location: $location');
//     }
//
//     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//       content: Text('Progress to Add Data'),
//       backgroundColor: Colors.blueAccent,
//     ));
//
//     final user = User(
//       name: _nameController.text,
//       username: _usernameController.text,
//       email: _emailController.text,
//       password: _passwordController.text,
//       phoneNumber: _phoneNumController.text,
//       location: _locationController.text,
//     );
//
//     final registerSuccessful = await _apiClient.registerUser(user);
//
//     if (registerSuccessful) {
//       ScaffoldMessenger.of(context).hideCurrentSnackBar();
//       Navigator.pushReplacement(context,
//           MaterialPageRoute(builder: (context) => const HomePage()));
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: Text('Error: $registerSuccessful'),
//         backgroundColor: Colors.red.shade300,
//       ));
//     }
//   }
// }