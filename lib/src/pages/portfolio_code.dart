import 'package:flutter/material.dart';
import 'package:portfolio/src/model/projects.dart';
import 'package:portfolio/src/responsive/responsive.dart';
import 'package:portfolio/src/storage/local_storage.dart';
import 'package:portfolio/src/widgets/box_button.dart';
import 'package:portfolio/src/widgets/enhanced_container.dart';
import 'package:portfolio/src/widgets/header.dart';
import 'package:url_launcher/url_launcher.dart';

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
  List<Project> projectsData = [];

  Future<void> fetchProjectsData() async {
    String projectsResponse = await getObject('projects');

    setState(() {
      projectsData = Projects.fromJson(projectsResponse).projects;
    });
  }

  late ScrollController listController = ScrollController();
  void navigateTo(String path, {Object? arguments}) {
    if (path.isNotEmpty) {
      Navigator.pushNamed(context, path, arguments: arguments);
    } else {
      Navigator.pop(context);
    }
  }

  void openAnotherPage(Uri uri) async {
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  @override
  void initState() {
    fetchProjectsData();
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
          leftButtonPath: '/skills',
          rightButtonPath: '/thanks-page',
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: ['4K', 'DESKTOP'].contains(responsive.screen) ? 50 : 8),
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
    );
  }

  Widget desktop() {
    double width = MediaQuery.of(context).size.width * 0.3;
    double height = MediaQuery.of(context).size.height;
    double cardArea = MediaQuery.of(context).size.width * 0.6;
    double cardSize = cardArea * 0.7 / 3;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        title(width: width > 550 ? 550 : width, height: height * 0.8, alignment: Alignment.topLeft),
        Container(
          height: height,
          width: cardArea,
          child: Scrollbar(
            thumbVisibility: true,
            child: ListView.builder(
              controller: listController,
              itemCount: (projectsData.length / 3).ceil(),
              itemBuilder: (BuildContext context, int index) {
                int startIndex = index * 3;
                int endIndex = startIndex + 3;
                List<Project> currentData = projectsData.sublist(startIndex, endIndex > projectsData.length ? projectsData.length : endIndex);
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: currentData
                      .map(
                        (data) => BoxButton(
                          onClick: () => openAnotherPage(Uri(scheme: data.scheme, host: data.host, path: data.path)),
                          child: EnhancedContainer(
                            width: cardSize,
                            height: cardSize,
                            margin: const EdgeInsets.all(16.0),
                            child: Center(
                              child: SelectableText.rich(
                                textAlign: TextAlign.center,
                                TextSpan(
                                  text: data.name,
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
    );
  }

  Widget tablet() {
    double width = MediaQuery.of(context).size.width * 0.9;
    double height = MediaQuery.of(context).size.height * 0.1;
    double cardSize = (MediaQuery.of(context).size.shortestSide - 16) * 0.7 / 3;

    return Wrap(
      runSpacing: 20,
      children: [
        title(width: width, height: height),
        Center(
          child: Container(
            width: width,
            height: MediaQuery.of(context).size.height - height - kToolbarHeight - 80,
            child: Scrollbar(
              thumbVisibility: true,
              child: ListView.builder(
                controller: listController,
                itemCount: (projectsData.length / 3).ceil(),
                itemBuilder: (BuildContext context, int index) {
                  int startIndex = index * 3;
                  int endIndex = startIndex + 3;
                  List<Project> currentData = projectsData.sublist(startIndex, endIndex > projectsData.length ? projectsData.length : endIndex);
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: currentData
                        .map(
                          (data) => BoxButton(
                            onClick: () => openAnotherPage(Uri(scheme: data.scheme, host: data.host, path: data.path)),
                            child: Center(
                              child: EnhancedContainer(
                                width: cardSize,
                                height: cardSize,
                                margin: const EdgeInsets.all(8.0),
                                child: Center(
                                  child: SelectableText.rich(
                                    textAlign: TextAlign.center,
                                    TextSpan(
                                      text: data.name,
                                      style: Theme.of(context).textTheme.bodyLarge,
                                    ),
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
        ),
      ],
    );
  }

  Widget mobile() {
    double width = MediaQuery.of(context).size.width * 0.9;
    double height = MediaQuery.of(context).size.height * 0.1;
    double cardSize = (MediaQuery.of(context).size.shortestSide - 16) * 0.6;
    double cardArea = MediaQuery.of(context).size.longestSide * 0.9 - height - kToolbarHeight;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        title(width: width, height: height),
        Container(
          height: cardArea,
          width: width,
          child: Scrollbar(
            thumbVisibility: true,
            controller: listController,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: projectsData
                    .map(
                      (data) => BoxButton(
                        onClick: () => openAnotherPage(Uri(scheme: data.scheme, host: data.host, path: data.path)),
                        child: EnhancedContainer(
                          width: cardSize,
                          height: cardSize,
                          margin: const EdgeInsets.all(16.0),
                          child: Center(
                            child: SelectableText.rich(
                              textAlign: TextAlign.center,
                              TextSpan(
                                text: data.name,
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget title({required double width, required double height, Alignment? alignment}) {
    return Align(
      alignment: alignment ?? Alignment.center,
      child: EnhancedContainer(
        width: width > 1200 ? 1200 : width,
        height: height,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Align(
            alignment: alignment ?? Alignment.center,
            child: SelectableText.rich(
              textAlign: TextAlign.justify,
              TextSpan(
                text: 'Códigos',
                style: Theme.of(context).textTheme.displayMedium,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
