import 'package:cached_network_image/cached_network_image.dart';
import 'package:cleaning_app/controller/profile.dart';
import 'package:cleaning_app/view/menu/profile.dart';
import 'package:cleaning_app/widget/glassmorphic_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

class EditProfile extends GetView<ProfileController> {
  void _showPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Gallery'),
                onTap: () {
                  controller.pickImage(ImageSource.gallery);
                  Get.back();
                },
              ),
              ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text('Camera'),
                onTap: () {
                  controller.pickImage(ImageSource.camera);
                  Get.back();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return WillPopScope(
      onWillPop: () async {
        Get.back(result: 'refresh');
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Edit Profile'),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Get.back(result: 'refresh');
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: formKey,
            child: KeyboardActions(
              config: buildKeyboardActionsConfig(
                context,
                fields: [
                  (focusNode: controller.firstNameFocus, nextFocusNode: controller.lastNameFocus),
                  (focusNode: controller.lastNameFocus, nextFocusNode: controller.emailFocus),
                  (focusNode: controller.emailFocus, nextFocusNode: controller.addressFocus),
                  (focusNode: controller.addressFocus, nextFocusNode: null),
                ],
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Profile picture
                    Obx(() {
                      return Center(
                        child: Stack(
                          children: [
                            GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  barrierColor: Colors.black12,
                                  builder: (_) => Dialog(
                                    backgroundColor: Colors.transparent,
                                    elevation: 10,
                                    child: CircleAvatar(
                                      radius: 100,
                                      child: AvatarCircle(
                                        imageUrl: controller.urlAvatar.value,
                                        size: 200,
                                      ),
                                    ),
                                  ),
                                );
                              },
                              child: CircleAvatar(
                                  radius: 60,
                                  backgroundColor: Colors.grey[200],
                                  child: ClipOval(
                                    child: SizedBox(
                                      width: 120,
                                      height: 120,
                                      child: CachedNetworkImage(
                                        imageUrl: controller.urlAvatar.value,
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) =>
                                            const CircularProgressIndicator(),
                                        errorWidget: (context, url, error) => const Icon(
                                          Icons.person,
                                          size: 60,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                  )),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.camera_alt,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                  onPressed: () => _showPicker(context),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                    const SizedBox(height: 30),

                    ProfileTextField(
                      focusNode: controller.firstNameFocus,
                      nextFocusNode: controller.lastNameFocus,
                      controller: controller.firstNameController,
                      hint: "first name",
                      label: "First Name",
                      inputType: TextInputType.text,
                    ),
                    ProfileTextField(
                      focusNode: controller.lastNameFocus,
                      nextFocusNode: controller.emailFocus,
                      controller: controller.lastNameController,
                      hint: "last name",
                      label: "Last Name",
                      inputType: TextInputType.text,
                    ),
                    ProfileTextField(
                      focusNode: controller.emailFocus,
                      nextFocusNode: controller.addressFocus,
                      controller: controller.emailController,
                      hint: "example@gmail.com",
                      label: "Email",
                      inputType: TextInputType.emailAddress,
                    ),
                    ProfileTextField(
                      focusNode: controller.addressFocus,
                      nextFocusNode: null,
                      controller: controller.ktpAddressController,
                      hint: "Alamat",
                      label: "Alamat",
                      inputType: TextInputType.text,
                    ),

                    SizedBox(
                      height: 100.h,
                    ),

                    // Save Button
                    Obx(() {
                      return SizedBox(
                        width: double.infinity,
                        height: 120.h,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue, foregroundColor: Colors.white),
                          onPressed: controller.isLoading.value
                              ? null
                              : () => controller.updateDetailUser(),
                          child: const Text(
                            'Save Profile',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      );
                    }),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ProfileTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final TextInputType inputType;
  final VoidCallback? ontap;
  final bool? readOnly;
  final FocusNode? focusNode; // ← tambahan
  final FocusNode? nextFocusNode;

  const ProfileTextField({
    super.key,
    required this.label,
    required this.hint,
    required this.inputType,
    required this.controller,
    this.readOnly,
    this.ontap,
    this.focusNode, // ← tambahan
    this.nextFocusNode,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          focusNode: focusNode,
          textInputAction: nextFocusNode != null ? TextInputAction.next : TextInputAction.done,
          onEditingComplete: () {
            if (nextFocusNode != null) {
              FocusScope.of(context).requestFocus(nextFocusNode);
            } else {
              FocusScope.of(context).unfocus();
            }
          },
          controller: controller,
          decoration: InputDecoration(
            labelText: label,
            hintText: hint,
            labelStyle: TextStyle(
              color: Colors.blueAccent,
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
            suffixIcon: readOnly != null
                ? Icon(
                    Icons.calendar_month_rounded,
                    color: Colors.grey,
                  )
                : null,
            hintStyle: TextStyle(
              color: Colors.grey,
              // fontSize: 14,
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue, width: 2),
              borderRadius: BorderRadius.circular(12),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(12),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(12),
            ),
            filled: true,
            fillColor: Color(0xfff7f9fc),
          ),
          readOnly: readOnly ?? false,
          onTap: ontap,
          // enabled: false,
          // style: TextStyle(fontSize: 16),
          keyboardType: inputType,
        ),
        SizedBox(
          height: 10,
        )
      ],
    );
  }
}
