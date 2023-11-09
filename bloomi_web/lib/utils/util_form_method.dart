import 'package:bloomi_web/components/custom_date_picker.dart';
import 'package:bloomi_web/components/custom_text.dart';
import 'package:bloomi_web/components/custom_time_picker.dart';
import 'package:bloomi_web/components/form_input_web.dart';
import 'package:bloomi_web/controllers/send_email_controller.dart';
import 'package:bloomi_web/providers/user_home_provider/appointment_provider.dart';
import 'package:bloomi_web/providers/user_home_provider/notification_provider.dart';
import 'package:bloomi_web/providers/users/user_provider.dart';
import 'package:bloomi_web/utils/util_constant.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

class UtilFormMethod {
  //---------------------------method to show dialog box input field---------------------------
  static showDialogMethod(BuildContext context, String counselorId,
      String counselorName, String counsellorEmail) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: Container(
            width: 600,
            height: 600,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2.0),
            ),
            child: AlertDialog(
              actions: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: 60.0, bottom: 20.0, left: 20.0, right: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Consumer2<UserProvider, AppointmentProvider>(
                        builder: (context, value, appointment, child) {
                          return Column(
                            children: [
                              FormInputWeb(
                                "Full Name",
                                textEditingController: appointment.name,
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Row(
                                    children: [
                                      Radio(
                                        value: "Option 1",
                                        groupValue: appointment.selectedOption,
                                        onChanged: (value) {
                                          appointment.setSelectedOption(
                                              value.toString());
                                        },
                                      ),
                                      const Text("Available Slot"),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Radio(
                                        value: "Option 2",
                                        groupValue: appointment.selectedOption,
                                        onChanged: (value) {
                                          appointment.setSelectedOption(
                                              value.toString());
                                        },
                                      ),
                                      const Text("Urgent Slot"),
                                    ],
                                  ),
                                ],
                              ),
                              if (appointment.selectedOption == "Option 1")
                                SizedBox(
                                  width: 400,
                                  height: 100,
                                  child: GridView.count(
                                    crossAxisCount:
                                        3, // Number of items per row
                                    childAspectRatio:
                                        1.8, // Width to height ratio of each item
                                    children: List.generate(20, (index) {
                                      return Container(
                                        width: 100,
                                        height: 100,
                                        margin: const EdgeInsets.all(5),
                                        color: Colors
                                            .red, // You can customize the color as needed
                                        child: Center(
                                          child: Text(
                                            'Slot ${index + 1}',
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                                  ),
                                ),
                              if (appointment.selectedOption == "Option 2")
                                const CustomDatePicker(),
                              const SizedBox(height: 10),
                              if (appointment.selectedOption == "Option 2")
                                const CustomTimePicker(),
                              const SizedBox(height: 10),
                              FormInputWeb(
                                "Enter the Note",
                                textEditingController: appointment.note,
                                maxLine: 4,
                              ),
                            ],
                          );
                        },
                      ),
                      const SizedBox(height: 50),
                      Consumer3<AppointmentProvider, UserProvider,
                          NotificationProvider>(
                        builder: (context, value, value2, value3, child) {
                          return ElevatedButton(
                            onPressed: () async {
                              try {
                                value
                                    .saveAppointment(
                                  context,
                                  value2.userModel!.uid,
                                  counselorId,
                                  value.name.text,
                                  counselorName,
                                  value2.userModel!.email,
                                  value2.userModel!.faculty,
                                  value.getDateTime.toString(),
                                  value.getTimeOfDay.format(context),
                                  "Pending",
                                  value.note.text,
                                )
                                    .then(
                                  (value1) {
                                    value3.saveNotification(
                                      context,
                                      value2.userModel!.uid,
                                      counselorId,
                                      value2.userModel!.name,
                                      counselorName,
                                      value.getDateTime.toString(),
                                      value.getTimeOfDay.format(context),
                                      "Pending",
                                      value.note.text,
                                    );
                                  },
                                );

                                try {
                                  SendEmailController().sendEmail(
                                    name: value2.userModel!.name,
                                    email: counsellorEmail,
                                    subject: "Appointment Request",
                                    message: value.note.text,
                                    reciverName: counselorName,
                                  );
                                } catch (e) {
                                  Logger().e(e);
                                }
                              } catch (e) {
                                Logger().e(e);
                              }
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateColor.resolveWith(
                                (states) {
                                  if (states.contains(MaterialState.hovered)) {
                                    return UtilConstants.greenColor;
                                  }
                                  return UtilConstants.greenColor;
                                },
                              ),
                              minimumSize: MaterialStateProperty.all(
                                  const Size(double.infinity, 60)),
                            ),
                            child: value.isLoading
                                ? const CircularProgressIndicator.adaptive()
                                : const CustomText(
                                    "Add Appointment",
                                    fontColor: UtilConstants.blackColor,
                                    fontSize: 15,
                                  ),
                          );
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
