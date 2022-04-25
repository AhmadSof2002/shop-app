
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mtgrk/layout/ShopLayout.dart';
import 'package:mtgrk/modules/register/regCubit/regCubit.dart';
import 'package:mtgrk/modules/register/regCubit/regStates.dart';

import 'package:mtgrk/shared/components/components.dart';
import 'package:mtgrk/shared/components/constants.dart';
import 'package:mtgrk/shared/network/local/cache_helper.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
    create: (BuildContext context) {
      return RegisterCubit();
    },
      child: BlocConsumer<RegisterCubit,RegisterStates>(
        builder: (context, state) =>  Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'REGISTER',
                          style: Theme.of(context).textTheme.headline3!.copyWith(
                              color: Colors.black,
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Register now to browse our different hot offers',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(color: Colors.black54),
                        ),
                        defaultFormField(
                            controller: nameController,
                            type: TextInputType.name,
                            label: 'Username',
                            prefix: Icons.person,
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return 'please enter a username';
                              }
                            }),
                        SizedBox(
                          height: 30,
                        ),
                        defaultFormField(
                            controller: emailController,
                            type: TextInputType.emailAddress,
                            label: 'Email Address',
                            prefix: Icons.email,
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return 'please enter an email address';
                              }
                            }),
                        SizedBox(
                          height: 15,
                        ),
                         defaultFormField(
                            controller: phoneController,
                            type: TextInputType.phone,
                            label: 'Phone number',
                            prefix: Icons.person,
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return 'please enter a phone number';
                              }
                            }),
                        SizedBox(height: 15,),
                        defaultFormField(
                            controller: passController,
                            isPassword: RegisterCubit.get(context).isPass,
                            type: TextInputType.visiblePassword,
                            label: 'Password',
                            suffix: RegisterCubit.get(context).suffix,
                            suffixPressed: () {
                              RegisterCubit.get(context).changePassVisibility();
                            },
                            onSubmit: (value) {
                              
                            },
                            prefix: Icons.lock_outline,
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return 'Password is too short';
                              }
                            }),
          
                        SizedBox(
                          height: 15.0,
                        ),
                        ConditionalBuilder(
                          condition:state is! RegisterLoadingState,
                          fallback: (BuildContext context) =>
                              Center(child: CircularProgressIndicator()),
                          builder: (BuildContext context) => defaultButton(
                            function: () {
                              if (formKey.currentState!.validate()) {
                                RegisterCubit.get(context).userRegister(
                                  name: nameController.text,
                                  phone: phoneController.text,
                                  email: emailController.text,
                                  password: passController.text,
                                );
                              }
                            },
                            text: 'REGISTER',
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        
                      ],
                    ),
                  ),
                ),
              ),
            )),
      
        listener: (context, state) {

          if (state is RegisterSuccessState) {
            if (state.RegisterModel.status!) {
              toastMessage(
                  msg: state.RegisterModel.message!, state: ToastStates.SUCCESS);
              CacheHelper.saveData(
                      key: 'token', value: state.RegisterModel.data!.token)
                  .then((value) {
                  
                      
                token = state.RegisterModel.data!.token!;
                print(token);
                navigateAndFinish(context, ShopLayout());
              });
            } else {
              toastMessage(
                  msg: state.RegisterModel.message!, state: ToastStates.ERROR);
            }
          }
        } ,
       ),
    );
  }
}
