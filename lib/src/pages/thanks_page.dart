import 'package:flutter/material.dart';
import 'package:portfolio/src/api/sheets/author_sheets_api.dart';
import 'package:portfolio/src/api/sheets/experience_sheets_api.dart';
import 'package:portfolio/src/api/sheets/thanks_sheets_api.dart';
import 'package:portfolio/src/model/author.dart';
import 'package:portfolio/src/model/experience.dart';
import 'package:portfolio/src/model/thanks.dart';
import 'package:portfolio/src/responsive/responsive.dart';
import 'package:portfolio/src/storage/local_storage.dart';
import 'package:portfolio/src/widgets/custom_dropdown.dart';
import 'package:portfolio/src/widgets/enhanced_card.dart';
import 'package:portfolio/src/widgets/header.dart';
import 'package:portfolio/src/widgets/pixelated_button.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ThanksPage extends StatefulWidget {
  static const routeName = '/thanks-page';
  final Object? arguments;
  final double page;
  final double numberOfPages;
  const ThanksPage({super.key, this.arguments, required this.page, required this.numberOfPages});

  @override
  State<ThanksPage> createState() => _ThanksPageState();
}

class _ThanksPageState extends State<ThanksPage> {
  late Author author;
  late Experiences experiences;
  late Thanks thanks;
  final language = ValueNotifier({'portuguese': 'Português'});
  final dropLanguageValues = {'english': 'English', 'portuguese': 'Português'};

  void navigateTo(String path, {Object? arguments}) {
    Navigator.pushNamed(context, path, arguments: arguments);
  }

  void openAnotherPage(Uri uri) async {
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  @override
  void initState() {
    author = Provider.of<Author>(context, listen: false);
    language.value = {author.language: dropLanguageValues[author.language]!};
    language.addListener(() {
      getAuthor();
      getExperiences();
      getThanks();
    });
    super.initState();
  }

  Future getAuthor() async {
    author.update(await AuthorSheetsApi.getByLanguage(language.value.keys.first));
    saveObject('author', author.toJson());
  }

  Future getExperiences() async {
    experiences.update(await ExperienceSheetsApi.getByLanguage(language.value.keys.first));
    saveObject('experiences', experiences.toJson());
  }

  Future getThanks() async {
    thanks.update(await ThanksSheetsApi.getByLanguage(language.value.keys.first));
    saveObject('thanks', thanks.toJson());
  }

  @override
  Widget build(BuildContext context) {
    Responsive responsive = Responsive(context: context);
    context.watch<Thanks>();
    thanks = context.read<Thanks>();

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: Header(
          page: widget.page,
          numberOfPages: widget.numberOfPages,
          leftButtonPath: '/portfolio-code',
          needRightButton: false,
        ),
      ),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Builder(builder: (BuildContext _) {
              switch (responsive.screen) {
                case '4K':
                  return desktop();
                case 'DESKTOP':
                  return desktop();
                case 'MOBILE':
                  return mobile();
                case 'TABLET':
                  return tablet();
                default:
                  return desktop();
              }
            }),
          ),
          Positioned(
            top: 16,
            right: 16,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PixelatedButton(
                  title: 'Curriculum',
                  onClick: () => openAnotherPage(Uri(
                    scheme: 'https',
                    host: 'drive.google.com',
                    path: author.cvPath,
                  )),
                  style: Theme.of(context).textTheme.labelSmall,
                ),
                SizedBox(
                  width: 16,
                ),
                ValueListenableBuilder(
                  valueListenable: language,
                  builder: (BuildContext context, Map<String, String> value, _) {
                    return CustomDropDown(
                      onClick: (value) {
                        for (var entry in dropLanguageValues.entries) {
                          var k = entry.key;
                          var v = entry.value;
                          if (v == value) {
                            language.value = {k: v};
                            break;
                          }
                        }
                      },
                      value: language.value.values.first,
                      items: dropLanguageValues.values.toList(),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Builder(builder: (BuildContext _) {
        switch (responsive.screen) {
          case '4K':
            return desktopBottomNavigationBar();
          case 'DESKTOP':
            return desktopBottomNavigationBar();
          case 'MOBILE':
            return mobileBottomNavigationBar();
          case 'TABLET':
            return tabletBottomNavigationBar();
          default:
            return desktopBottomNavigationBar();
        }
      }),
    );
  }

  Widget mobile() {
    double width = MediaQuery.of(context).size.width * 0.9;
    double height = MediaQuery.of(context).size.height * 0.4;
    return EnhancedCard(
      width: width > 1200 ? 1200 : width,
      height: height > 400 ? 400 : height,
      mainAxisAlignment: MainAxisAlignment.center,
      content: content(
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget tablet() {
    double width = MediaQuery.of(context).size.width * 0.8;
    double height = MediaQuery.of(context).size.height * 0.4;
    return EnhancedCard(
      width: width > 1200 ? 1200 : width,
      height: height > 400 ? 400 : height,
      mainAxisAlignment: MainAxisAlignment.center,
      content: content(),
    );
  }

  Widget desktop() {
    double width = MediaQuery.of(context).size.width * 0.8;
    double height = MediaQuery.of(context).size.height * 0.4;
    return EnhancedCard(
      width: width > 1200 ? 1200 : width,
      height: height > 400 ? 400 : height,
      mainAxisAlignment: MainAxisAlignment.center,
      content: content(),
    );
  }

  Widget mobileBottomNavigationBar() {
    return SizedBox(
      height: 180,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: buttons(),
      ),
    );
  }

  Widget tabletBottomNavigationBar() {
    return SizedBox(
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: buttons(),
      ),
    );
  }

  Widget desktopBottomNavigationBar() {
    return SizedBox(
      height: 160,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: buttons(),
      ),
    );
  }

  List<Widget> buttons({double? width, double? height}) {
    return [
      Container(
        padding: const EdgeInsets.all(16),
        child: PixelatedButton(
          width: width,
          height: height,
          title: 'Home',
          onClick: () => navigateTo('/landing-page'),
        ),
      ),
      Container(
        padding: const EdgeInsets.all(16),
        child: PixelatedButton(
          width: width,
          height: height,
          title: 'Recursos',
          onClick: () => print('recursos'),
        ),
      ),
    ];
  }

  Widget content({TextAlign textAlign = TextAlign.justify}) {
    return Column(
      children: [
        SelectableText.rich(
          textAlign: textAlign,
          TextSpan(
            text: thanks.thanksTitle,
            style: Theme.of(context).textTheme.displayLarge,
          ),
        ),
        SizedBox(
          height: 16,
        ),
        SelectableText.rich(
          textAlign: textAlign,
          TextSpan(
            text: thanks.thanksPhrase,
            style: Theme.of(context).textTheme.displaySmall,
          ),
        ),
      ],
    );
  }
}
