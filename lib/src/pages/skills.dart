import 'package:flutter/material.dart';
import 'package:portfolio/src/responsive/responsive.dart';
import 'package:portfolio/src/widgets/box_button.dart';
import 'package:portfolio/src/widgets/enhanced_container.dart';
import 'package:portfolio/src/widgets/header.dart';

class Skills extends StatefulWidget {
  static const routeName = '/skills';
  final Object? arguments;
  final double page;
  final double numberOfPages;
  const Skills({super.key, this.arguments, required this.page, required this.numberOfPages});

  @override
  State<Skills> createState() => _SkillsState();
}

class _SkillsState extends State<Skills> {
  List skillsData = [
    'Flutter',
    'Dart',
    'Clean Code',
    'React',
    'Javascript',
    'Typescript',
    'Git',
    'HTML',
    'CSS',
    'SQL',
    'NOSQL',
    'CI/CD',
  ];
  ScrollController listController = ScrollController();
  bool showSideButtons = false;

  void navigateTo(String path, {Object? arguments}) {
    if (path.isNotEmpty) {
      Navigator.pushNamed(context, path, arguments: arguments);
    } else {
      Navigator.pop(context);
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    listController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Responsive responsive = Responsive(context: context);

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: Header(
          page: widget.page,
          numberOfPages: widget.numberOfPages,
          leftButtonPath: '',
          rightButtonPath: '/portfolio-code',
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: ['4K', 'DESKTOP'].contains(responsive.screen) ? 100 : 16),
        child: Builder(builder: (BuildContext _) {
          switch (responsive.screen) {
            case '4K':
              return desktop();
            case 'DESKTOP':
              return desktop();
            case 'MOBILE':
              return mobile();
            case 'TABLET':
              return mobile();
            default:
              return desktop();
          }
        }),
      ),
    );
  }

  Widget desktop() {
    double width = MediaQuery.of(context).size.width * 0.9;
    double height = MediaQuery.of(context).size.height * 0.1;
    return Wrap(
      runSpacing: 20,
      children: [
        title(width: width, height: height),
        Align(
          alignment: Alignment.center,
          child: EnhancedContainer(
            width: width > 1200 ? 1200 : width,
            height: MediaQuery.of(context).size.height - kToolbarHeight - 150 - height,
            child: Row(
              children: [
                Expanded(
                  child: Scrollbar(
                    thumbVisibility: true,
                    controller: listController,
                    child: ListView.builder(
                      itemCount: (skillsData.length / 3).ceil(),
                      itemBuilder: (BuildContext context, int index) {
                        int startIndex = index * 3;
                        int endIndex = startIndex + 3;
                        List currentData = skillsData.sublist(startIndex, endIndex > skillsData.length ? skillsData.length : endIndex);
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          if (listController.hasClients && listController.position.hasPixels) {
                            setState(() {
                              showSideButtons = true;
                            });
                          } else {
                            setState(() {
                              showSideButtons = false;
                            });
                          }
                        });
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: currentData
                              .map(
                                (skill) => Container(
                                  width: ((width > 1200 ? 1200 : width) / 3) - 30,
                                  height: 200,
                                  alignment: Alignment.center,
                                  child: SelectableText.rich(
                                    TextSpan(
                                      text: skill,
                                      style: Theme.of(context).textTheme.displaySmall,
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                        );
                      },
                    ),
                  ),
                ),
                sideButtons(size: 40),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget mobile() {
    double width = MediaQuery.of(context).size.width * 0.9;
    double height = MediaQuery.of(context).size.height * 0.1;
    return Column(
      children: [
        title(width: width, height: height),
        SizedBox(
          height: 20,
        ),
        EnhancedContainer(
          width: width,
          height: MediaQuery.of(context).size.height - kToolbarHeight - height - 120,
          child: Row(
            children: [
              Expanded(
                child: Scrollbar(
                  thumbVisibility: true,
                  controller: listController,
                  child: ListView.builder(
                    itemCount: (skillsData.length / 2).ceil(),
                    itemBuilder: (BuildContext context, int index) {
                      int startIndex = index * 2;
                      int endIndex = startIndex + 2;
                      List currentData = skillsData.sublist(startIndex, endIndex > skillsData.length ? skillsData.length : endIndex);
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        if (listController.hasClients && listController.position.hasPixels) {
                          setState(() {
                            showSideButtons = true;
                          });
                        } else {
                          setState(() {
                            showSideButtons = false;
                          });
                        }
                      });
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: currentData
                            .map(
                              (skill) => Container(
                                width: (width / 2) - 30,
                                height: height,
                                alignment: Alignment.center,
                                child: SelectableText.rich(
                                  TextSpan(
                                    text: skill,
                                    style: Theme.of(context).textTheme.displaySmall,
                                  ),
                                  textScaleFactor: 0.7,
                                ),
                              ),
                            )
                            .toList(),
                      );
                    },
                  ),
                ),
              ),
              sideButtons(size: 30),
            ],
          ),
        ),
      ],
    );
  }

  Widget title({required double width, required double height}) {
    return Align(
      alignment: Alignment.center,
      child: EnhancedContainer(
        width: width > 1200 ? 1200 : width,
        height: height > 100 ? 100 : height,
        child: Center(
          child: SelectableText.rich(
            textAlign: TextAlign.justify,
            TextSpan(
              text: 'Competências',
              style: Theme.of(context).textTheme.displayMedium,
            ),
          ),
        ),
      ),
    );
  }

  Widget sideButtons({required double size}) {
    return Visibility(
      visible: showSideButtons,
      child: SizedBox(
        width: size + 20,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BoxButton(
              onClick: () => {
                listController.animateTo(
                  0,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.ease,
                )
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  'assets/icons/UpButton.png',
                  fit: BoxFit.scaleDown,
                  width: size,
                  height: size,
                ),
              ),
            ),
            BoxButton(
              onClick: () => {
                listController.animateTo(
                  listController.position.maxScrollExtent,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.ease,
                )
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  'assets/icons/DownButton.png',
                  fit: BoxFit.scaleDown,
                  width: size,
                  height: size,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
