import 'package:bloomi_web/components/background_color_gradient.dart';
import 'package:bloomi_web/components/custom_text.dart';
import 'package:bloomi_web/components/dropdown_button.dart';
import 'package:bloomi_web/components/form_button_web.dart';
import 'package:bloomi_web/components/form_heading.dart';
import 'package:bloomi_web/components/form_input_web.dart';
import 'package:bloomi_web/providers/auth/signup_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Studentform extends StatefulWidget {
  const Studentform({
    super.key,
    required this.mediaQueryData,
  });
  final MediaQueryData mediaQueryData;
  @override
  State<Studentform> createState() => _StudentformState();
}

class _StudentformState extends State<Studentform> {
  List<String> listItems = [
    'Faculty of Engineering',
    'Faculty of Medicine',
    'Faculty of Dental Sciences',
    'Faculty of Veterinary Medicine and Animal Science',
    'Faculty of Science',
    'Faculty of Agriculture',
    'Faculty of Allied Health Sciences',
    'Faculty of Arts',
    'Faculty of Management',
  ];

  List<String> year = [
    '1st Year',
    '2nd Year',
    '3rd Year',
    '4th Year',
  ];
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 200),
          child: Column(
            children: [
              SizedBox(height: mediaQueryData.size.height * 0.02),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    margin:
                        EdgeInsets.only(top: mediaQueryData.size.height * 0.02),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        FormHeading("Register Students",
                            mediaQueryData: mediaQueryData),
                        SizedBox(height: mediaQueryData.size.height * 0.04),
                        FormInputWeb("Name",
                            textEditingController:
                                Provider.of<SignupProvider>(context).name,
                            mediaQueryData: mediaQueryData),
                        SizedBox(height: mediaQueryData.size.height * 0.01),
                        FormInputWeb("Email",
                            textEditingController:
                                Provider.of<SignupProvider>(context).email,
                            mediaQueryData: mediaQueryData),
                        SizedBox(height: mediaQueryData.size.height * 0.01),
                        FormInputWeb(
                          "Password",
                          textEditingController:
                              Provider.of<SignupProvider>(context).password,
                          mediaQueryData: mediaQueryData,
                          obscure: true,
                        ),
                        SizedBox(height: mediaQueryData.size.height * 0.01),
                        FormInputWeb("Phone Number",
                            textEditingController:
                                Provider.of<SignupProvider>(context)
                                    .phoneNumber,
                            mediaQueryData: mediaQueryData),
                        SizedBox(height: mediaQueryData.size.height * 0.01),
                        CustomDropdownMenu(
                          "Faculty",
                          listItem: listItems,
                          textEditingController:
                              Provider.of<SignupProvider>(context).faculty,
                        ),
                        SizedBox(height: mediaQueryData.size.height * 0.01),
                        FormInputWeb("Department",
                            textEditingController:
                                Provider.of<SignupProvider>(context).department,
                            mediaQueryData: mediaQueryData),
                        SizedBox(height: mediaQueryData.size.height * 0.01),
                        CustomDropdownMenu(
                          "Level of Study",
                          listItem: year,
                          textEditingController:
                              Provider.of<SignupProvider>(context).year,
                        ),
                        SizedBox(height: mediaQueryData.size.height * 0.06),
                        Consumer<SignupProvider>(
                          builder: (context, value, child) {
                            return InkWell(
                              onTap: () {
                                Provider.of<SignupProvider>(context,
                                        listen: false)
                                    .signUpUser(
                                        value.email.text,
                                        value.password.text,
                                        mediaQueryData,
                                        context);
                              },
                              child: FormButtonWeb(
                                "Register",
                                mediaQueryData: mediaQueryData,
                              ),
                            );
                          },
                        ),
                        SizedBox(height: mediaQueryData.size.height * 0.02),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: mediaQueryData.size.height * 0.1,
              ),
              Center(
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue,
                      onPrimary: Colors.white,
                      elevation: 100,
                      padding: const EdgeInsets.all(20),
                    ),
                    child: const Text(
                      'Go Back',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}