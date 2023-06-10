import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
//import 'package:intl/locale.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale = Locale('en');
  ThemeMode _themeMode = ThemeMode.dark;
  @override
  Widget build(BuildContext context) {
    Color surfaceColor = Colors.white10;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Localizations Sample App',
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      locale: _locale,
      theme: _themeMode == ThemeMode.dark
          ? MyAppThemeConfig.dark().getTheme(_locale.languageCode)
          : MyAppThemeConfig.light().getTheme(_locale.languageCode),
      home: MyHomePage(
        toggleThemeMode: () {
          setState(() {
            if (_themeMode == ThemeMode.dark)
              _themeMode = ThemeMode.light;
            else
              (_themeMode = ThemeMode.dark);
          });
        },
        selectedLanguageChaned: (_Language newSelectedLanguageByUser) {
          setState(() {
            _locale = newSelectedLanguageByUser == _Language.en
                ? Locale('en')
                : Locale('fa');
          });
        },
      ),
    );
  }
}

class MyAppThemeConfig {
  static const String faPrimaryFontFamily = 'IranYekan';
  final Color primaryTextColor;
  final Color secondaryTextColor;
  final Color surfaceColor;
  final Color backGroundColor;
  final Color appBarColor;
  final Brightness brightness;

  MyAppThemeConfig.dark()
      : primaryTextColor = Colors.white,
        secondaryTextColor = Colors.white70,
        surfaceColor = Color(0x0dffffff),
        backGroundColor = Color.fromARGB(255, 30, 30, 30),
        appBarColor = Colors.black,
        brightness = Brightness.dark;

  MyAppThemeConfig.light()
      : primaryTextColor = Colors.grey.shade900,
        secondaryTextColor = Colors.grey.shade900.withOpacity(0.8),
        surfaceColor = Color(0x0d000000),
        backGroundColor = Colors.white,
        appBarColor = Colors.blueGrey,
        brightness = Brightness.light;

  ThemeData getTheme(String languageCode) {
    return ThemeData(
        brightness: brightness,
        dividerTheme: DividerThemeData(),
        inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none),
            filled: true,
            fillColor: surfaceColor),
        dividerColor: surfaceColor,
        scaffoldBackgroundColor: backGroundColor,
        appBarTheme: AppBarTheme(backgroundColor: appBarColor, elevation: 0),
        primarySwatch: Colors.blue,
        primaryColor: Colors.blue,
        textTheme: languageCode == 'en' ? enPrimaryText : faPrimaryText);
  }

  TextTheme get enPrimaryText => GoogleFonts.latoTextTheme(TextTheme(
      bodyText2: TextStyle(fontSize: 15, color: primaryTextColor),
      bodyText1: TextStyle(fontSize: 12, color: secondaryTextColor),
      headline6:
          TextStyle(fontWeight: FontWeight.w900, color: primaryTextColor),
      subtitle1: TextStyle(
          fontSize: 16, fontWeight: FontWeight.bold, color: primaryTextColor)));

  TextTheme get faPrimaryText => (TextTheme(
      bodyText2: TextStyle(
          fontSize: 15,
          height: 1.5,
          color: primaryTextColor,
          fontFamily: faPrimaryFontFamily),
      bodyText1: TextStyle(
          fontSize: 12,
          height: 1.5,
          color: secondaryTextColor,
          fontFamily: faPrimaryFontFamily),
      caption: TextStyle(fontFamily: faPrimaryFontFamily),
      headline6: TextStyle(
          fontWeight: FontWeight.w900,
          fontSize: 18,
          color: primaryTextColor,
          fontFamily: faPrimaryFontFamily),
      subtitle1: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: primaryTextColor,
          fontFamily: faPrimaryFontFamily)));
}

class MyHomePage extends StatefulWidget {
  final Function() toggleThemeMode;
  final Function(_Language _language) selectedLanguageChaned;
  const MyHomePage(
      {super.key,
      required this.toggleThemeMode,
      required this.selectedLanguageChaned});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  _MySkills _skill = _MySkills.flutter;
  _Language __language = _Language.en;

  void _updateSkill(_MySkills mySkills) {
    setState(() {
      _skill = mySkills;
    });
  }

  void _updtaeLanguage(_Language language) {
    widget.selectedLanguageChaned(language);
    setState(() {
      __language = language;
    });
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(appLocalizations.profileTitle),
        actions: [
          Icon(CupertinoIcons.chat_bubble_2),
          InkWell(
            onTap: widget.toggleThemeMode,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 16, 0),
              child: Icon(CupertinoIcons.lightbulb_fill),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: const EdgeInsets.all(32),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    'assets/images/mee.png',
                    width: 70,
                    height: 60,
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.name,
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Text(appLocalizations.job),
                      const SizedBox(
                        height: 12,
                      ),
                      Row(
                        children: [
                          Icon(
                            CupertinoIcons.location_solid,
                            size: 16,
                            color: Theme.of(context).textTheme.bodyText1!.color,
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Text(
                            appLocalizations.location,
                            style: Theme.of(context).textTheme.caption,
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Icon(
                  CupertinoIcons.device_laptop,
                  color: Theme.of(context).primaryColor,
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(32, 0, 32, 0),
            child: Text(
              appLocalizations.summary,
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.fromLTRB(32, 16, 32, 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(appLocalizations.select),
                CupertinoSlidingSegmentedControl<_Language>(
                    groupValue: __language,
                    children: {
                      _Language.en: Text(
                        appLocalizations.language1,
                        style: const TextStyle(fontSize: 14),
                      ),
                      _Language.fa: Text(appLocalizations.language2,
                          style: const TextStyle(fontSize: 14))
                    },
                    onValueChanged: (value) {
                      if (value != null) _updtaeLanguage(value);
                    })
              ],
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.fromLTRB(32, 16, 32, 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(AppLocalizations.of(context)!.skill,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2!
                        .copyWith(fontWeight: FontWeight.w900)),
                const SizedBox(
                  width: 2,
                ),
                const Icon(
                  CupertinoIcons.chevron_down,
                  size: 12,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Center(
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              direction: Axis.horizontal,
              children: [
                Skills(
                  title: 'Flutter',
                  imagepath: ('assets/images/flutter.jpg'),
                  isActive: _skill == _MySkills.flutter,
                  ShadowColor: Colors.blue,
                  type: _MySkills.flutter,
                  onTap: (() => _updateSkill(_MySkills.flutter)),
                ),
                Skills(
                  title: 'Dart',
                  imagepath: ('assets/images/dart.png'),
                  ShadowColor: Colors.orange,
                  isActive: _skill == _MySkills.dart,
                  type: _MySkills.dart,
                  onTap: () => _updateSkill(_MySkills.dart),
                ),
                Skills(
                  title: 'Docker',
                  imagepath: ('assets/images/docker.png'),
                  ShadowColor: Colors.purple,
                  isActive: _skill == _MySkills.docker,
                  type: _MySkills.docker,
                  onTap: () => _updateSkill(_MySkills.docker),
                ),
                Skills(
                  title: 'Figma',
                  imagepath: ('assets/images/figma.png'),
                  ShadowColor: Colors.blue,
                  isActive: _skill == _MySkills.figma,
                  type: _MySkills.figma,
                  onTap: () => _updateSkill(_MySkills.figma),
                ),
                Skills(
                  title: 'Git',
                  imagepath: ('assets/images/git.png'),
                  ShadowColor: Colors.pink.shade500,
                  isActive: _skill == _MySkills.git,
                  type: _MySkills.git,
                  onTap: () => _updateSkill(_MySkills.git),
                ),
                Skills(
                  title: 'Firebase',
                  imagepath: ('assets/images/firebase.png'),
                  isActive: _skill == _MySkills.fireBase,
                  ShadowColor: Colors.yellow,
                  type: _MySkills.fireBase,
                  onTap: () => _updateSkill(_MySkills.fireBase),
                ),
              ],
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.fromLTRB(32, 12, 32, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(AppLocalizations.of(context)!.info,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2!
                        .copyWith(fontWeight: FontWeight.w900)),
                const SizedBox(
                  height: 12,
                ),
                TextField(
                  decoration: InputDecoration(
                      hintText: appLocalizations.emali,
                      prefixIcon: Icon(CupertinoIcons.at)),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  decoration: InputDecoration(
                      hintText: appLocalizations.pass,
                      prefixIcon: Icon(CupertinoIcons.lock)),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                        onPressed: () {},
                        child: Text(appLocalizations.saveInfo)))
              ],
            ),
          )
        ]),
      ),
    );
  }
}

class Skills extends StatelessWidget {
  final _MySkills type;
  final String title;
  final String imagepath;
  final Color ShadowColor;
  final bool isActive;
  final Function() onTap;

  const Skills({
    Key? key,
    required this.title,
    required this.imagepath,
    required this.ShadowColor,
    required this.isActive,
    required this.type,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final BorderRadius defaultBorderRadius = BorderRadius.circular(12);
    return InkWell(
      borderRadius: defaultBorderRadius,
      onTap: onTap,
      child: Container(
        width: 110,
        height: 110,
        decoration: isActive
            ? BoxDecoration(
                color: Theme.of(context).dividerColor,
                borderRadius: defaultBorderRadius)
            : null,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
            decoration: isActive
                ? BoxDecoration(
                    boxShadow: [BoxShadow(color: ShadowColor, blurRadius: 20)])
                : null,
            child: ClipRRect(
              borderRadius: defaultBorderRadius,
              child: Image.asset(
                imagepath,
                width: 50,
                height: 50,
              ),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(title)
        ]),
      ),
    );
  }
}

enum _MySkills { flutter, dart, docker, figma, fireBase, git }

enum _Language { fa, en }
