import 'package:flutter/material.dart';
import 'package:portfolio/src/widgets/box_button.dart';
import 'package:portfolio/src/widgets/enhanced_card.dart';
import 'package:portfolio/src/widgets/enhanced_container.dart';
import 'package:portfolio/src/widgets/header.dart';

class PortfolioCode extends StatefulWidget {
  static const routeName = '/portfolio-code';
  final Object? arguments;
  final double page;
  final double numberOfPages;
  const PortfolioCode({super.key, this.arguments, required this.page, required this.numberOfPages});

  @override
  State<PortfolioCode> createState() => _PortfolioCodeState();
}

class _PortfolioCodeState extends State<PortfolioCode> {
  List<Map> pagesCode = [
    {
      'page': 'Home',
      'pathToCode': '/code/home',
    },
    {
      'page': 'Sobre mim',
      'pathToCode': '/code/about-me',
    },
    {
      'page': 'Experiências',
      'pathToCode': '/code/experiences',
    },
    {
      'page': 'Competências',
      'pathToCode': '/code/skills',
    },
    {
      'page': 'Código desse portfolio',
      'pathToCode': '/code/portifolio-code',
    },
    {
      'page': 'Header',
      'pathToCode': '/code/header',
    },
    {
      'page': 'Enhanced Container',
      'pathToCode': '/code/enhanced-container',
    },
    {
      'page': 'Enhanced Card',
      'pathToCode': '/code/enhanced-card',
    },
    {
      'page': 'Lifebar',
      'pathToCode': '/code/lifebar',
    },
    {
      'page': 'Pixelated Button',
      'pathToCode': '/code/pixelated-button',
    },
    {
      'page': 'Pixelated Clipper Square',
      'pathToCode': '/code/pixelated-clipper-square',
    },
    {
      'page': 'Box Button',
      'pathToCode': '/code/box-button',
    }
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
            rightButtonPath: '/experiences',
          ),
        ),
        body: Container(
          padding: const EdgeInsets.all(50),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                flex: 1,
                child: EnhancedCard(
                  margin: const EdgeInsets.all(16),
                  width: 550,
                  height: 600,
                  header: Container(
                    padding: const EdgeInsets.all(20),
                    child: SelectableText.rich(
                      textAlign: TextAlign.justify,
                      TextSpan(
                        text: 'Código desse portfolio',
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                    ),
                  ),
                ),
              ),
              Flexible(
                flex: 2,
                child: Scrollbar(
                  thumbVisibility: true,
                  child: ListView.builder(
                    controller: listController,
                    itemCount: (pagesCode.length / 3).ceil(),
                    itemBuilder: (BuildContext context, int index) {
                      int startIndex = index * 3;
                      int endIndex = startIndex + 3;
                      List<Map> currentData = pagesCode.sublist(startIndex, endIndex > pagesCode.length ? pagesCode.length : endIndex);
                      return Row(
                        children: currentData
                            .map(
                              (page) => BoxButton(
                                onClick: () => navigateTo(page['pathToCode']),
                                child: EnhancedContainer(
                                  width: 300,
                                  height: 300,
                                  margin: const EdgeInsets.all(16.0),
                                  child: Center(
                                    child: SelectableText.rich(
                                      textAlign: TextAlign.center,
                                      TextSpan(
                                        text: page['page'],
                                        style: Theme.of(context).textTheme.bodyLarge,
                                      ),
                                    ),
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
            ],
          ),
        ));
  }
}
