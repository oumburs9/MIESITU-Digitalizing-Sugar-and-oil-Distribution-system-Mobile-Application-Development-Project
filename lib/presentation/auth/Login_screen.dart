// ignore_for_file: prefer_const_constructors

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:miesitu/application/auth/bloc/auth_bloc.dart';
import 'package:miesitu/application/auth/events/auth_events.dart';
import 'package:miesitu/application/auth/states/auth_state.dart';
import 'package:miesitu/domain/auth/entity/auth_model.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miesitu/gloabl/route_name_constants.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LoginScreen> {
  final emailTextFormFieldController = TextEditingController();

  final passwordTextFormFieldController = TextEditingController();
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(actions: [(Icon(Icons.person))]),
        backgroundColor: Colors.white,
        body: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is LoggingIn) {
              CircularProgressIndicator();
            } else if (state is LoginSuccess) {
              GoRouter.of(context).push('userhome');
            } else if (state is LogginError) {
              Text(state.errorMsg);
              print("error");
            }
          },
          child: SafeArea(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // SizedBox(width: 50),
                          Column(
                            children: [
                              SizedBox(
                                width: 50,
                              )
                            ],
                          ),
                          SizedBox(height: 30),
                          Text('Login_ To_ Account',
                              style: TextStyle(
                                  fontSize: 34,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff2e2e2e))),
                          SizedBox(height: 5),
                          Divider(
                            endIndent: 100,
                            indent: 100,
                          ),
                          const Text('Insert your username or email',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff919191))),
                          SizedBox(height: 25),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 40),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Email',
                                    style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xff919191))),
                                SizedBox(height: 8),
                                Material(
                                  elevation: 2,
                                  borderRadius: BorderRadius.circular(5),
                                  child: TextFormField(
                                    controller: emailTextFormFieldController,
                                    keyboardType: TextInputType.emailAddress,
                                    textAlign: TextAlign.left,
                                    validator: (String? val) {
                                      if (val == null || val.isEmpty) {
                                        return "Email Required to login";
                                      }
                                      if (!RegExp(
                                              r"""^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+""")
                                          .hasMatch(val))
                                        return "Invalid email";
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      // prefix: Text('+251 '),
                                      focusedBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                      disabledBorder: InputBorder.none,
                                      hintText: 'Email',
                                      fillColor: Colors.white,
                                      filled: true,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        borderSide: BorderSide.none,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 40),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Password',
                                    style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xff919191))),
                                SizedBox(height: 8),
                                Material(
                                  elevation: 2,
                                  borderRadius: BorderRadius.circular(5),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: TextFormField(
                                          controller:
                                              passwordTextFormFieldController,
                                          obscuringCharacter: '*',
                                          obscureText: obscureText,
                                          decoration: InputDecoration(
                                              fillColor: Colors.white,
                                              filled: true,
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                borderSide: BorderSide.none,
                                              ),
                                              hintText: 'Password'),
                                        ),
                                      ),
                                      IconButton(
                                        icon: Icon(obscureText
                                            ? Icons.visibility
                                            : Icons.visibility_off),
                                        onPressed: () {
                                          setState(() {
                                            obscureText = !obscureText;
                                          });
                                        },
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          BlocConsumer<AuthBloc, AuthState>(
                            builder: (context, state) {
                              print(state);
                              if (state is LoggingIn) {
                                print("progress");
                                return const Center(
                                    child: SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(),
                                ));
                              } else {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 40, vertical: 10),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          InkWell(
                                              onTap: () {
                                                if (!_formKey.currentState!
                                                    .validate()) return;
                                                final authBloc =
                                                    context.read<AuthBloc>();

                                                authBloc.add((LoginEvent(
                                                    login: Login(
                                                        email:
                                                            emailTextFormFieldController
                                                                .text,
                                                        password:
                                                            passwordTextFormFieldController
                                                                .text))));
                                              },
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 30,
                                                    vertical: 20),
                                                decoration: BoxDecoration(
                                                  color: Color(0xff0a6430),
                                                  borderRadius:
                                                      BorderRadius.circular(28),
                                                ),
                                                child: Icon(
                                                  FontAwesomeIcons.arrowRight,
                                                  size: 15,
                                                  color: Colors.white,
                                                ),
                                              )),
                                        ],
                                      ),
                                      if (state is LogginError)
                                        Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              color: Colors.red),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 15, vertical: 10),
                                          child: Text(state.errorMsg,
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w300,
                                                  color: Colors.white)),
                                        )
                                    ],
                                  ),
                                );
                              }
                            },
                            listener: (context, state) {
                              if (state is LoginSuccess) {
                                print("userhomeGoing");
                                context.goNamed(userHomeRoute);
                                return;
                              }
                              if (state is AdminLoginSuccess) {
                                print("adminhomeGoing");
                                context.goNamed(adminHomeRoute);
                              }
                            },
                          ),
                          SizedBox(
                            child: Center(
                              child: ElevatedButton(
                                  onPressed: () {
                                    GoRouter.of(context).push("/adminhome");
                                  },
                                  child: Text("AdminHome")),
                            ),
                            height: 25,
                          ),
                          SizedBox(
                            height: 25,
                            child: ElevatedButton(
                              onPressed: () {
                                GoRouter.of(context).push('/addproduct');
                              },
                              child: Text("addProduct"),
                            ),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          RichText(
                            text: TextSpan(
                                text: "Don\'t_ have_ an_ account? ",
                                style: TextStyle(
                                  color: Color(0xff222222),
                                  fontSize: 15,
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: 'Sign_ up',
                                      style: TextStyle(
                                          color: Color(0xff0a6430),
                                          fontSize: 15),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          context.goNamed(registerRoute);
                                        })
                                ]),
                          ),
                        ],
                      ),
                    ]),
              ),
            ),
          ),
        ));
  }
}
