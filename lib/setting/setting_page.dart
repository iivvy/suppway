import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:suppwayy_mobile/commons/main_page.dart';
import 'package:suppwayy_mobile/trace/bloc/trace_bloc.dart';

import 'bloc/setting_bloc.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  late bool _theme;

  List<String> languageCode = ['en_US', 'fr'];
  List<String> languageName = ['English', 'Français'];
  String currentLanguage = "English";
  List<int> maxSavedTracesList = [5, 10, 15, 20];
  late int maxSavedTraces = 5;

  @override
  void initState() {
    super.initState();
    _theme = BlocProvider.of<SettingBloc>(context).theme == 'dark';
    Locale lang = LocalizedApp.of(context).delegate.currentLocale;
    currentLanguage = languageName[languageCode.indexOf(lang.toString())];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            BlocProvider.of<TraceBloc>(context).add(GetTraceHistory());
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const MainPage(
                  defaultIndex: 0,
                ),
              ),
            );
          },
        ),
        title: Text(translate('app_bar.settingtitle')),
      ),
      body: BlocConsumer<SettingBloc, SettingState>(
        listener: (context, state) async {
          if (state is SettingLoadedError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                duration: const Duration(seconds: 10),
                content: Text(state.error),
              ),
            );
          } else if (state is SettingsLoaded) {
            await changeLocale(
              context,
              state.settings.language,
            );
            setState(() {
              _theme = BlocProvider.of<SettingBloc>(context).theme == 'dark';

              Locale lang = LocalizedApp.of(context).delegate.currentLocale;
              currentLanguage =
                  languageName[languageCode.indexOf(lang.toString())];
            });
          }
        },
        builder: (context, state) {
          if (state is SettingsLoaded) {
            bool _isDark = state.settings.theme == 'dark' ? true : false;
            maxSavedTraces = state.settings.maxSavedTraces;

            return Center(
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: <
                      Widget>[
                Card(
                  margin: const EdgeInsets.only(top: 10.0),
                  elevation: 4.0,
                  shadowColor: Colors.indigo,
                  child: SwitchListTile(
                    title: Text(translate('theme.dark')),
                    value: _theme,
                    activeColor: Colors.indigo.shade100,
                    onChanged: (bool value) {
                      BlocProvider.of<SettingBloc>(context).add(
                          UpdateSettingStringValue(
                              key: 'theme', value: value ? 'dark' : 'light'));
                    },
                    secondary: Icon(
                        _isDark == false ? Icons.light_mode : Icons.dark_mode),
                  ),
                ),
                Card(
                  margin: const EdgeInsets.only(top: 10.0),
                  elevation: 4.0,
                  shadowColor: Colors.indigo,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: DropdownButton<String>(
                      isExpanded: true,
                      icon: const Icon(
                        Icons.arrow_drop_down,
                      ),
                      underline: Container(
                        height: 2,
                      ),
                      onChanged: (String? newValue) {
                        BlocProvider.of<SettingBloc>(context).add(
                            UpdateSettingStringValue(
                                key: 'language',
                                value: languageCode[
                                    languageName.indexOf(newValue!)]));
                      },
                      value: currentLanguage,
                      items: languageName
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0, right: 100),
                  child: Text(translate("settigns.max_histories"),
                      style: Theme.of(context).textTheme.headline6),
                ),
                Card(
                  margin: const EdgeInsets.only(top: 10.0),
                  elevation: 4.0,
                  shadowColor: Colors.indigo,
                  child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: DropdownButton<int>(
                        icon: const Icon(
                          Icons.arrow_drop_down,
                        ),
                        underline: Container(
                          height: 2,
                        ),
                        isExpanded: true,
                        onChanged: (int? newVal) {
                          BlocProvider.of<SettingBloc>(context).add(
                              UpdateSettingIntegerValue(
                                  key: 'maxSavedTraces', value: newVal!));
                          BlocProvider.of<TraceBloc>(context).add(
                              UpdateTraceHistory(newMaxSavedHistory: newVal));

                          setState(() {
                            maxSavedTraces = newVal;
                          });
                        },
                        value: maxSavedTraces,
                        items: maxSavedTracesList.map((int value) {
                          return DropdownMenuItem<int>(
                            value: value,
                            child: Text(value.toString()),
                          );
                        }).toList(),
                      )),
                ),
              ]),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
