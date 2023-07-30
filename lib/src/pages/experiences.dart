import 'package:flutter/material.dart';
import 'package:portfolio/src/model/experience.dart';
import 'package:portfolio/src/responsive/responsive.dart';
import 'package:portfolio/src/widgets/enhanced_card.dart';
import 'package:portfolio/src/widgets/enhanced_container.dart';
import 'package:portfolio/src/widgets/header.dart';
import 'package:portfolio/src/widgets/pixelated_button.dart';
import 'package:provider/provider.dart';

class ExperiencesPage extends StatefulWidget {
  static const routeName = '/experiences';
  final Object? arguments;
  final double page;
  final double numberOfPages;
  const ExperiencesPage({super.key, this.arguments, required this.page, required this.numberOfPages});

  @override
  State<ExperiencesPage> createState() => _ExperiencesPageState();
}

class _ExperiencesPageState extends State<ExperiencesPage> {
  late Experiences listOfExperience;

  @override
  void initState() {
    super.initState();
  }

  void navigateTo(String path, {Object? arguments}) {
    if (path.isNotEmpty) {
      Navigator.pushNamed(context, path, arguments: arguments);
    } else {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    Responsive responsive = Responsive(context: context);
    listOfExperience = context.read<Experiences>();

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: Header(
          page: widget.page,
          numberOfPages: widget.numberOfPages,
          leftButtonPath: '/about-me',
          rightButtonPath: '/skills',
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
              return tablet();
            default:
              return desktop();
          }
        }),
      ),
    );
  }

  Widget mobile() {
    double width = MediaQuery.of(context).size.width * 0.9;
    double height = MediaQuery.of(context).size.height * 0.1;
    return Container(
      child: Column(
        children: [
          title(width: width, height: height),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: Scrollbar(
              thumbVisibility: true,
              child: ListView.builder(
                itemCount: listOfExperience.experiences.length,
                itemBuilder: (BuildContext context, int index) {
                  return enhacedCard(
                    width: width - 8,
                    height: MediaQuery.of(context).size.height - kToolbarHeight - 250 - height,
                    margin: EdgeInsets.only(bottom: 16),
                    trophySize: 30,
                    experience: listOfExperience.experiences[index],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget tablet() {
    double width = MediaQuery.of(context).size.width * 0.9;
    double height = MediaQuery.of(context).size.height * 0.1;
    double cardHeight = MediaQuery.of(context).size.height - kToolbarHeight - 180 - height;
    double cardWidth = MediaQuery.of(context).size.width * 0.4;
    if (cardHeight < cardWidth) {
      cardHeight = cardWidth;
    }
    return Wrap(
      runSpacing: 20,
      children: [
        title(width: width, height: height),
        Container(
          height: MediaQuery.of(context).size.height - kToolbarHeight - height - 80,
          alignment: Alignment.center,
          child: ListView.builder(
            itemCount: (listOfExperience.experiences.length / 2).ceil(),
            itemBuilder: (BuildContext context, int index) {
              int startIndex = index * 2;
              int endIndex = startIndex + 2;
              List<Experience>? currentData = listOfExperience.experiences
                  .sublist(startIndex, endIndex > listOfExperience.experiences.length ? listOfExperience.experiences.length : endIndex);
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: currentData
                    .map(
                      (experience) => enhacedCard(
                        width: cardWidth,
                        height: cardHeight,
                        margin: EdgeInsets.only(bottom: 16),
                        trophySize: 30,
                        experience: experience,
                      ),
                    )
                    .toList(),
              );
            },
          ),
        )
      ],
    );
  }

  Widget desktop() {
    double width = MediaQuery.of(context).size.width * 0.9;
    double height = MediaQuery.of(context).size.height * 0.1;
    return Wrap(
      runSpacing: 20,
      children: [
        title(width: width, height: height),
        Container(
          height: MediaQuery.of(context).size.height - kToolbarHeight - 250,
          alignment: Alignment.center,
          child: ListView.builder(
            itemCount: (listOfExperience.experiences.length / 3).ceil(),
            itemBuilder: (BuildContext context, int index) {
              int startIndex = index * 3;
              int endIndex = startIndex + 3;
              List<Experience> currentData = listOfExperience.experiences
                  .sublist(startIndex, endIndex > listOfExperience.experiences.length ? listOfExperience.experiences.length : endIndex);
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: currentData
                    .map(
                      (experience) => enhacedCard(
                        width: MediaQuery.of(context).size.width / 4,
                        height: MediaQuery.of(context).size.height - kToolbarHeight - 250 - height,
                        experience: experience,
                      ),
                    )
                    .toList(),
              );
            },
          ),
        )
      ],
    );
  }

  Widget enhacedCard({
    required double width,
    required double height,
    Experience? experience,
    EdgeInsetsGeometry? margin,
    double trophySize = 40,
    double? buttonWidth,
    double? buttonHeight,
  }) {
    return EnhancedCard(
      width: width,
      height: height > 600 ? 600 : height,
      margin: margin,
      header: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Image.asset(
              'assets/icons/trophy.png',
              fit: BoxFit.scaleDown,
              width: trophySize,
              height: trophySize,
            ),
          ),
          SelectableText.rich(
            TextSpan(
              text: experience?.company,
              style: Theme.of(context).textTheme.displaySmall,
            ),
          ),
        ],
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 8.0),
          Text(experience?.description ?? ''),
          SizedBox(height: 8.0),
          ...?experience?.listOfDescription.map(
            (e) => SelectableText.rich(
              TextSpan(
                text: '\n* ' + e.replaceAll('\n', ''),
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ),
        ],
      ),
      footer: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '${experience?.startDate}\n${experience?.endDate ?? 'Atualmente'}',
          ),
          Opacity(
            opacity: experience?.seeMore != null ? 1 : 0,
            child: PixelatedButton(
              title: 'Veja mais',
              onClick: () => navigateTo(experience!.seeMore),
              style: Theme.of(context).textTheme.labelSmall,
            ),
          )
        ],
      ),
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
              text: 'Experiências',
              style: Theme.of(context).textTheme.displayMedium,
            ),
          ),
        ),
      ),
    );
  }
}
