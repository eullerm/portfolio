import 'package:flutter/material.dart';
import 'package:portfolio/src/api/sheets/author_sheets_api.dart';
import 'package:portfolio/src/model/author.dart';
import 'package:portfolio/src/responsive/responsive.dart';
import 'package:portfolio/src/storage/shared_preferences.dart';
import 'package:portfolio/src/widgets/custom_dropdown.dart';
import 'package:portfolio/src/widgets/enhanced_card.dart';
import 'package:portfolio/src/widgets/header.dart';
import 'package:portfolio/src/widgets/pixelated_button.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class LandingPage extends StatefulWidget {
  static const routeName = '/landing-page';
  final Object? arguments;
  final double page;
  final double numberOfPages;
  const LandingPage({super.key, this.arguments, required this.page, required this.numberOfPages});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final language = ValueNotifier({'portuguese': 'Português'});
  final dropLanguageValues = {'english': 'English', 'portuguese': 'Português'};
  Map cv = {
    'english': Uri(
      scheme: 'https',
      host: 'drive.google.com',
      path: '/file/d/1W0ODUlfJDdTEcYXN3D0Gplyh6PiVzLuV/view',
    ),
    'portuguese': Uri(
      scheme: 'https',
      host: 'drive.google.com',
      path: '/file/d/1cD850ORC9c-16mOYbCz549h5cQUrieby/view',
    )
  };

  Author? author;

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
    super.initState();
    author = Provider.of<Author>(context, listen: false);
    language.addListener(() => getAuthor());
    getAuthor();
  }

  Future getAuthor() async {
    author?.update(await AuthorSheetsApi.getByLanguage(language.value.keys.first));
    saveObjectToPrefs('author', author?.toJson() ?? '');
  }

  @override
  Widget build(BuildContext context) {
    Responsive responsive = Responsive(context: context);
    context.watch<Author?>();
    author = context.read<Author?>();
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: Header(
          page: widget.page,
          numberOfPages: widget.numberOfPages,
          needLeftButton: false,
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
                  onClick: () => openAnotherPage(cv[language.value.keys.first]),
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
          title: 'Start',
          onClick: () => navigateTo('/about-me'),
        ),
      ),
      Container(
        padding: const EdgeInsets.all(16),
        child: PixelatedButton(
          width: width,
          height: height,
          title: 'Menu',
          onClick: () => print('menu'),
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
            text: author?.name,
            style: Theme.of(context).textTheme.displayLarge,
          ),
        ),
        SizedBox(
          height: 16,
        ),
        SelectableText.rich(
          textAlign: textAlign,
          TextSpan(
            text: author?.role,
            style: Theme.of(context).textTheme.displaySmall,
          ),
        ),
      ],
    );
  }
}
