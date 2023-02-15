import 'package:flutter/material.dart';
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
  ];
  late ScrollController listController = ScrollController();

  void navigateTo(String path, {Object? arguments}) {
    if (path.isNotEmpty) {
      Navigator.pushNamed(context, path, arguments: arguments);
    } else {
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    listController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
        padding: const EdgeInsets.all(50),
        child: Wrap(
          runSpacing: 50,
          children: [
            Align(
              alignment: Alignment.center,
              child: EnhancedContainer(
                width: 1200,
                height: 100,
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
            ),
            Align(
              alignment: Alignment.center,
              child: EnhancedContainer(
                width: 1800,
                height: 600,
                child: Row(
                  children: [
                    Expanded(
                      child: Scrollbar(
                        thumbVisibility: true,
                        child: ListView.builder(
                          controller: listController,
                          itemCount: (skillsData.length / 3).ceil(),
                          itemBuilder: (BuildContext context, int index) {
                            int startIndex = index * 3;
                            int endIndex = startIndex + 3;
                            List currentData = skillsData.sublist(startIndex, endIndex > skillsData.length ? skillsData.length : endIndex);
                            return Row(
                              children: currentData
                                  .map(
                                    (skill) => Container(
                                      width: (1800 / 3) - 30,
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
                    SizedBox(
                      width: 60,
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
                                width: 40,
                                height: 40,
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
                                width: 40,
                                height: 40,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
