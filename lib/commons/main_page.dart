import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:suppwayy_mobile/profile/bloc/bloc/profile_bloc.dart';
import 'package:suppwayy_mobile/authentication/bloc/authentication_bloc.dart';
import 'package:suppwayy_mobile/authentication/login_page.dart';

import 'package:suppwayy_mobile/commons/home_page.dart';
import 'package:suppwayy_mobile/payment/payment_page.dart';
import 'package:suppwayy_mobile/trace/bloc/trace_bloc.dart';
import 'package:suppwayy_mobile/trace/trace_history_list_page.dart';
import 'package:suppwayy_mobile/trace/trace_repository.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key, required this.defaultIndex}) : super(key: key);
  final int defaultIndex;
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  TraceService traceService = TraceService();

  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (index == 1) {
        BlocProvider.of<TraceBloc>(context).add(GetTraceHistory());
      }
      if (index == 2) {
        BlocProvider.of<ProfileBloc>(context).add(GetProfileEvent());
      }
    });
  }

  final List<Widget> _widgetOptions = <Widget>[
    const HomePage(),
    const TracePage(),
    const PaymentPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
      if (state is AuthenticationInitial) {
        var userName = state.userName;
        var userPassword = state.userPassword;

        if (userName != null && userPassword != null) {
          BlocProvider.of<AuthenticationBloc>(context).add(Authenticate(
              userName: userName.toString(),
              userPassword: userPassword.toString()));
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const LoginPage(),
            ),
          );
        }
      } else if (state is Authenticated) {
        // BlocProvider.of<AuthenticationBloc>(context)..add(GetInfos());
        // } else if (state is AuthenticationError) {
        //   Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //       builder: (context) => const LoginPage(),
        //     ),
        //   );
      }
    }, builder: (context, state) {
      if (state is Authenticated) {
        return Scaffold(
          body: SafeArea(child: _widgetOptions.elementAt(_selectedIndex)),
          bottomNavigationBar: BottomNavigationBar(
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: const Icon(Icons.home),
                label: translate("homepage.bottomNavigationBar.home"),
              ),
              BottomNavigationBarItem(
                icon:
                    const ImageIcon(AssetImage("assets/images/tracehome.png")),
                label: translate("homepage.bottomNavigationBar.trace"),
              ),
              BottomNavigationBarItem(
                icon: const Icon(
                  IconData(0xe481, fontFamily: 'MaterialIcons'),
                ),
                label: translate("homepage.bottomNavigationBar.payment"),
              ),
            ],
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
          ),
        );
      }
      return Center(
          child: CircularProgressIndicator(
        color: Theme.of(context).primaryColor,
      ));
    });
  }
}
