import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:BabyShop/consts/colors.dart';
import 'package:BabyShop/consts/firebase_consts.dart';
import 'package:BabyShop/services/auth_hepler.dart';
import 'package:BabyShop/screens/users/user_widget/beveled_button.dart';
import 'package:BabyShop/screens/users/user_widget/bg_widget.dart';
import 'package:BabyShop/screens/users/user_widget/custom_form.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditDetail extends StatefulWidget {
  final dynamic data;
  const EditDetail({Key? key, this.data}) : super(key: key);

  @override
  State<EditDetail> createState() => _EditDetailState();
}

class _EditDetailState extends State<EditDetail> {
  Uint8List? profileImageWeb;
  String? profileImagePath;
  bool isLoading = false;

  var nameController = TextEditingController();
  var oldpassController = TextEditingController();
  var newPassController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController.text = widget.data["name"];
  }

  @override
  Widget build(BuildContext context) {
    return bgWidget(
      child: Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ClipOval(
                  child: profileImageWeb != null
                      ? Image.memory(
                          profileImageWeb!,
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                        )
                      : profileImagePath != null
                          ? Image.file(
                              File(profileImagePath!),
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                            )
                          : Image.memory(
                              base64Decode(widget.data['imageurl']),
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                            ),
                ),
                const SizedBox(height: 10),
                BeveledButton(
                  title: "Change",
                  onTap: () async {
                    await changeImage();
                    await updateProfileImage();
                    setState(() {}); // Trigger a rebuild to update the UI
                  },
                  width: 130,
                ),
                const Divider(),
                const SizedBox(height: 20),
                CustomTextField(
                  label: 'Name',
                  hint: 'Change Name',
                  ispass: false,
                  controller: nameController,
                ),
                CustomTextField(
                  label: 'Password',
                  hint: 'Old Password',
                  ispass: true,
                  controller: oldpassController,
                ),
                CustomTextField(
                  label: 'Password',
                  hint: 'New Password',
                  ispass: true,
                  controller: newPassController,
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 50,
                  child: isLoading
                      ? const Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 3,
                          ),
                        )
                      : BeveledButton(
                          title: 'Change Data',
                          onTap: () => updateUserDetails(context),
                          width: 180,
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// 📌 **Method: Sirf Profile Image Update Karega**
  Future<void> updateProfileImage() async {
    try {
      if ((kIsWeb && profileImageWeb == null) ||
          (!kIsWeb && profileImagePath == null)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.red,
            content:
                Text('Please select an image', style: TextStyle(fontSize: 18)),
          ),
        );
        return;
      }

      setState(() {
        isLoading = true;
      });

      String base64image;
      if (kIsWeb) {
        base64image = base64Encode(profileImageWeb!);
      } else {
        base64image = base64Encode(File(profileImagePath!).readAsBytesSync());
      }

      await FirebaseFirestore.instance
          .collection(userCollection)
          .doc(currentUser!.uid)
          .update({"imageurl": base64image});

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.green,
          content: Text('Profile image updated successfully!',
              style: TextStyle(fontSize: 18)),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text('Failed to update image: $e',
              style: const TextStyle(fontSize: 18)),
        ),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  /// 📌 **Method: Sirf User Details Update Karega**
  Future<void> updateUserDetails(BuildContext context) async {
    try {
      setState(() {
        isLoading = true;
      });
      if (widget.data['password'] == oldpassController.text) {
        await AuthenticationHelper().changeAuthPassword(
            email: widget.data['email'],
            password: oldpassController.text,
            newpassword: newPassController.text);

        await FirebaseFirestore.instance
            .collection(userCollection)
            .doc(currentUser!.uid)
            .update({
          "name": nameController.text,
          "password": newPassController.text,
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.green,
            content: Text('User details updated successfully!',
                style: TextStyle(fontSize: 18)),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.red,
            content: Text('Wrong password', style: TextStyle(fontSize: 18)),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text('Failed to update details: $e',
              style: const TextStyle(fontSize: 18)),
        ),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  /// 📌 **Method: Image Select Karne ke liye**
  Future<void> changeImage() async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile == null) return;

      if (kIsWeb) {
        profileImageWeb = await pickedFile.readAsBytes();
      } else {
        profileImagePath = pickedFile.path;
      }
      notifyListeners();
    } catch (e) {
      debugPrint("Error picking image: $e");
    }
  }

  void notifyListeners() {}
}
