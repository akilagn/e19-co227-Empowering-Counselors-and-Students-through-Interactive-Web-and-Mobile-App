import 'package:bloomi_web/components/custom_image_column.dart';
import 'package:bloomi_web/components/custom_text.dart';
import 'package:bloomi_web/components/custom_text_link_web.dart';
import 'package:bloomi_web/components/customicon_container.dart';
import 'package:bloomi_web/components/form_button_web.dart';
import 'package:bloomi_web/components/form_heading.dart';
import 'package:bloomi_web/components/form_input_web.dart';
import 'package:bloomi_web/providers/auth/login_provider.dart';
import 'package:bloomi_web/screens/auth_screens/forgotPassword/forgot_password.dart';
import 'package:bloomi_web/screens/auth_screens/signup/signup_form.dart';
import 'package:bloomi_web/utils/util_constant.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginDesktop extends StatelessWidget {
  const LoginDesktop({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const SizedBox(height: 100),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const SizedBox(width: 10),
                      const Column(
                        children: [
                          CustomImageColumn(),
                          SizedBox(
                            width: 420,
                            child: CustomText(
                                "BLOOMi helps you connect and share your feelings with your mentors",
                                fontColor: UtilConstants.blackColor,
                                fontSize: 17,
                                fontWeight: FontWeight.w300),
                          ),
                        ],
                      ),
                      const SizedBox(width: 10),
                      Column(
                        children: [
                          Container(
                            width: 460,
                            height: 520,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 40),
                            decoration: BoxDecoration(
                              color: UtilConstants.lightgreyColor,
                              borderRadius: BorderRadius.circular(
                                  UtilConstants.boardRadiusForm),
                            ),
                            child: Column(
                              children: [
                                const FormHeading(
                                  "Login Here",
                                ),
                                const SizedBox(height: 40),
                                FormInputWeb(
                                  "Email",
                                  textEditingController:
                                      Provider.of<LoginProvider>(context).email,
                                ),
                                const SizedBox(height: 10),
                                FormInputWeb(
                                  "Password",
                                  textEditingController:
                                      Provider.of<LoginProvider>(context)
                                          .password,
                                ),
                                const SizedBox(height: 10),
                                const CustomTextLinkWeb("Forgot password?",
                                    route: ForgotPassword()),
                                const SizedBox(height: 20),
                                Consumer<LoginProvider>(
                                  builder: (context, value, child) {
                                    return InkWell(
                                      onTap: () {
                                        value.signInUser(value.email.text,
                                            value.password.text, context);
                                      },
                                      child: FormButtonWeb(
                                        "Login",
                                        isLoading: value.isLoading,
                                      ),
                                    );
                                  },
                                ),
                                const SizedBox(height: 10),
                                const CustomTextLinkWeb("Create new account?",
                                    route: SignUp()),
                                const SizedBox(height: 30),
                                const CustomText(
                                  "Or login with social account",
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                                const SizedBox(height: 15),
                                const Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    CustomIconContainer(
                                      imgPath: UtilConstants.googleImagePath,
                                    ),
                                    SizedBox(width: 50),
                                    CustomIconContainer(
                                      imgPath: UtilConstants.facebookImagePath,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 10),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
