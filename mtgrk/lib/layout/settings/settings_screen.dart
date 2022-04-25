import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mtgrk/cubit/cubit.dart';
import 'package:mtgrk/cubit/states.dart';
import 'package:mtgrk/shared/components/components.dart';
import 'package:mtgrk/shared/components/constants.dart';

class SettingsScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var nameContorller = TextEditingController();
  var emailContorller = TextEditingController();
  var phoneContorller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var userModel = ShopCubit.get(context).userModel;
        while (userModel == null) {
          return Center(child: CircularProgressIndicator());
        }
        nameContorller.text = userModel.data!.name!;
        emailContorller.text = userModel.data!.email!;
        phoneContorller.text = userModel.data!.phone!;

        return ConditionalBuilder(
          condition: ShopCubit.get(context).userModel != null,
          builder: (context) => Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    if (state is ShopLoadingUpdateUserState)
                      LinearProgressIndicator(),
                    SizedBox(
                      height: 12,
                    ),
                    defaultFormField(
                        controller: nameContorller,
                        type: TextInputType.name,
                        label: 'Name',
                        prefix: Icons.person,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'name must not be empty';
                          }
                          return null;
                        }),
                    SizedBox(
                      height: 20,
                    ),
                    defaultFormField(
                        controller: emailContorller,
                        type: TextInputType.emailAddress,
                        label: 'Email Address',
                        prefix: Icons.email,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'email address must not be empty';
                          }
                          return null;
                        }),
                    SizedBox(
                      height: 20,
                    ),
                    defaultFormField(
                        controller: phoneContorller,
                        type: TextInputType.phone,
                        label: 'Phone Number',
                        prefix: Icons.phone,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'phone number must not be empty';
                          }
                          return null;
                        }),
                    SizedBox(
                      height: 20,
                    ),
                    defaultButton(
                        function: () {
                          if (formKey.currentState!.validate()) {
                            ShopCubit.get(context).updateUserData(
                                name: nameContorller.text,
                                email: emailContorller.text,
                                phone: phoneContorller.text);
                          }
                        },
                        text: 'UPDATE'),
                    SizedBox(
                      height: 20,
                    ),
                    defaultButton(
                        function: () {
                          if (formKey.currentState!.validate()) {
                            signOut(context);
                          }
                        },
                        text: 'LOGOUT'),
                  ],
                ),
              ),
            ),
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
