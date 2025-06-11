import 'package:cached_network_image/cached_network_image.dart';
import 'package:cleaning_app/controller/profile.dart';
import 'package:cleaning_app/view/menu/profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class EditProfile extends GetView<ProfileController> {
  final _formKey = GlobalKey<FormState>();


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
    return Scaffold(
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
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile picture
              Obx(() {
                return Center(
                  child: Stack(
                    children: [
                      GestureDetector(
                        onTap: (){
                          showDialog(
                            context: context,
                            barrierColor: Colors.black12,
                            builder: (_) =>
                                Dialog(
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
                                  errorWidget: (context, url, error) =>
                                  const Icon(
                                    Icons.person,
                                    size: 60,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            )
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            color: Theme
                                .of(context)
                                .primaryColor,
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
                controller: controller.firstNameController,
                hint: "first name",
                label: "First Name",
                inputType: TextInputType.text,
              ),
              ProfileTextField(
                controller: controller.lastNameController,
                hint: "last name",
                label: "Last Name",
                inputType: TextInputType.text,
              ),
              ProfileTextField(
                controller: controller.emailController,
                hint: "example@gmail.com",
                label: "Email",
                inputType: TextInputType.emailAddress,
              ),
              ProfileTextField(
                controller: controller.ktpAddressController,
                hint: "Alamat",
                label: "Alamat",
                inputType: TextInputType.text,
              ),

              Spacer(),

              // Save Button
              Obx(() {
                return SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
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

  const ProfileTextField({
    super.key,
    required this.label,
    required this.hint,
    required this.inputType,
    required this.controller, this.readOnly, this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: controller,
          decoration: InputDecoration(
            labelText: label,
            hintText: hint,
            labelStyle: TextStyle(
              color: Colors.blueAccent,
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
            suffixIcon: readOnly != null ? Icon(Icons.calendar_month_rounded,color: Colors.grey,) : null,
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
