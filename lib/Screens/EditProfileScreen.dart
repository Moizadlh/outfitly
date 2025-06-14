import 'package:flutter/material.dart';
import 'package:outfitly/DatabaseContext/DbContext.dart';
import 'package:outfitly/Models/UsersModel.dart'; // Import your model here
import 'package:intl/intl.dart'; // For formatting dates

class EditProfilePage extends StatefulWidget {
  final UsersModel user;

  EditProfilePage({required this.user});

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();
  DbContext? _dbContext;

  late TextEditingController fullNameController;
  late TextEditingController phoneController;
  late TextEditingController emailController;
  late TextEditingController addressController;
  DateTime? selectedBirthDate; // Date variable for the birthdate

  @override
  void initState() {
    super.initState();
    _dbContext = DbContext();
    fullNameController = TextEditingController(text: widget.user.FullName);
    phoneController = TextEditingController(text: widget.user.Phone);
    emailController = TextEditingController(text: widget.user.Email);
    addressController = TextEditingController(text: widget.user.Address);

    // Parse the birthdate from string if available
    if (widget.user.BirthDate != null && widget.user.BirthDate!.isNotEmpty) {
      selectedBirthDate = DateFormat('yyyy-MM-dd').parse(widget.user.BirthDate!);
    }
  }

  @override
  void dispose() {
    fullNameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    addressController.dispose();
    super.dispose();
  }

  void _saveProfile() {
    if (_formKey.currentState!.validate()) {
      // Update the user model with new data
      widget.user.FullName = fullNameController.text;
      widget.user.Phone = phoneController.text.isNotEmpty ? phoneController.text : null;
      widget.user.Email = emailController.text;
      widget.user.Address = addressController.text.isNotEmpty ? addressController.text : null;

      // Convert DateTime to string before saving
      widget.user.BirthDate = selectedBirthDate != null
          ? DateFormat('yyyy-MM-dd').format(selectedBirthDate!)
          : null;
      _dbContext!.UpdateUser(widget.user);
      // Perform the action to save updated data
      print("Profile updated: ${widget.user}");
      Navigator.pop(context);
    }
  }

  Future<void> _selectBirthDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedBirthDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null && pickedDate != selectedBirthDate) {
      setState(() {
        selectedBirthDate = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: fullNameController,
                decoration: InputDecoration(labelText: 'Full Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your full name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: phoneController,
                decoration: InputDecoration(labelText: 'Phone (Optional)'),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  return null; // No validation for optional fields
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: addressController,
                decoration: InputDecoration(labelText: 'Address (Optional)'),
                validator: (value) {
                  return null; // No validation for optional fields
                },
              ),
              SizedBox(height: 10),
              GestureDetector(
                onTap: () => _selectBirthDate(context),
                child: AbsorbPointer(
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Birth Date (Optional)',
                    ),
                    controller: TextEditingController(
                      text: selectedBirthDate != null
                          ? DateFormat('yyyy-MM-dd').format(selectedBirthDate!)
                          : '',
                    ),
                    validator: (value) {
                      return null; // No validation for optional fields
                    },
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveProfile,
                child: Text('Save Changes'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
