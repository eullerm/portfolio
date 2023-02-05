import 'package:flutter/material.dart';
import 'package:portfolio/src/widgets/enhanced_card.dart';
import 'package:portfolio/src/widgets/enhanced_container.dart';
import 'package:portfolio/src/widgets/header.dart';
import 'package:portfolio/src/widgets/pixelated_button.dart';

class Experiences extends StatefulWidget {
  static const routeName = '/experiences';
  final Object? arguments;
  final double page;
  final double numberOfPages;
  const Experiences({super.key, this.arguments, required this.page, required this.numberOfPages});

  @override
  State<Experiences> createState() => _ExperiencesState();
}

class _ExperiencesState extends State<Experiences> {
  List<Map> experiencesData = [
    {
      'local': 'Pibit',
      'description': 'Realizei todas as etapas do desenvolvimento de um aplicativo, tais como:',
      'listOfDescription': [
        'Estruturação das ideias;',
        'Especificação do aplicativo;',
        'Escolha da tecnologia;',
        'Desenvolvimento;',
        'Prototipação;',
        'Testes.',
      ],
      'startDate': 'Out de 2019',
      'endDate': 'Out de 2021',
      'seeMore': '/pibit'
    },
    {
      'local': 'Exablack',
      'description': 'Atuei em e-commerces que utilizavam phtml e magento, realizando:',
      'listOfDescription': [
        'Desenvolvimento;',
        'Manutenção;',
        'Testes;',
        'Suporte técnico.',
      ],
      'startDate': 'Nov de 2020',
      'endDate': 'Jul de 2021',
      'seeMore': null
    },
    {
      'local': 'Wikki Brasil',
      'description': 'Atuo no desenvolvendo full stack de aplicações web com tecnologias como:',
      'listOfDescription': [
        'React.js;',
        'Typescript;',
        'Mongodb;',
        'Next.js.',
      ],
      'startDate': 'Jan de 2022',
      'endDate': null,
      'seeMore': null
    },
  ];

  void navigateTo(String path, {Object? arguments}) {
    if (path.isNotEmpty) {
      Navigator.pushNamed(context, path, arguments: arguments);
    } else {
      Navigator.pop(context);
    }
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
          rightButtonPath: '/skills',
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
                      text: 'Experiências',
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height - kToolbarHeight - 250,
              alignment: Alignment.center,
              child: ListView.builder(
                itemCount: (experiencesData.length / 3).ceil(),
                itemBuilder: (BuildContext context, int index) {
                  int startIndex = index * 3;
                  int endIndex = startIndex + 3;
                  List<Map> currentData = experiencesData.sublist(startIndex, endIndex > experiencesData.length ? experiencesData.length : endIndex);
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: currentData
                        .map(
                          (experience) => EnhancedCard(
                            height: 600,
                            width: 500,
                            header: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                  child: Image.asset(
                                    'assets/icons/trophy.png',
                                    fit: BoxFit.scaleDown,
                                    width: 40,
                                    height: 40,
                                  ),
                                ),
                                SelectableText.rich(
                                  TextSpan(
                                    text: experience['local'],
                                    style: Theme.of(context).textTheme.displaySmall,
                                  ),
                                ),
                              ],
                            ),
                            content: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 8.0),
                                Text(experience['description']),
                                SizedBox(height: 8.0),
                                ...experience['listOfDescription'].map(
                                  (e) => SelectableText.rich(
                                    TextSpan(
                                      text: '\n* ${e}',
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
                                  '${experience['startDate']}\n${experience['endDate'] ?? 'Atualmente'}',
                                ),
                                Opacity(
                                  opacity: experience['seeMore'] != null ? 1 : 0,
                                  child: PixelatedButton(
                                    width: 160,
                                    height: 50,
                                    title: 'Veja mais',
                                    onClick: () => navigateTo(experience['seeMore']),
                                    style: Theme.of(context).textTheme.labelSmall,
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                        .toList(),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
