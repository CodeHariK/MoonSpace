import 'dart:io';
import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:moonspace/form/async_text_field.dart';
import 'package:moonspace/helper/extensions/theme_ext.dart';

import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:moonspace/theme.dart';

class ManagerApp extends StatefulWidget {
  const ManagerApp({super.key});

  @override
  State<ManagerApp> createState() => _ManagerAppState();
}

class _ManagerAppState extends State<ManagerApp>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();

  late TabController _tabController;
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);

    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        _pageController.jumpToPage(_tabController.index);
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    PageView.custom(
      childrenDelegate: SliverChildBuilderDelegate((c, i) {
        return SizedBox();
      }),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Manager',
          style: GoogleFonts.ibmPlexMono(textStyle: context.h4),
        ),
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: Icon(Icons.arrow_back),
        ),
        actions: [IconButton.outlined(onPressed: () {}, icon: Icon(Icons.add))],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TabBar(
              controller: _tabController,
              tabs: const [
                Tab(text: 'Video'),
                Tab(text: 'Photos'),
                Tab(text: 'Audio'),
              ],
            ),
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: PageView.custom(
          controller: _pageController,
          onPageChanged: (index) => _tabController.animateTo(index),
          childrenDelegate: SliverChildBuilderDelegate(childCount: 3, (
            context,
            index,
          ) {
            if (index == 1) {
              return ListView(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(60),
                    child: Container(
                      margin: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        border: Border.all(width: 3, color: context.cSec),
                        borderRadius: BorderRadius.circular(32),
                      ),
                      child: Column(
                        children: [
                          Text(
                            "LineChart",
                            style: GoogleFonts.ibmPlexMono(
                              textStyle: context.h6,
                            ),
                          ),
                          const SizedBox(height: 10),
                          SizedBox(height: 200, child: SimpleLineChart()),
                        ],
                      ),
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border.all(width: 3, color: context.cSec),
                      borderRadius: BorderRadius.circular(32),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "LineChart",
                          style: GoogleFonts.ibmPlexMono(textStyle: context.h6),
                        ),
                        const SizedBox(height: 10),

                        SizedBox(height: 200, child: SimpleBarChart()),
                      ],
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border.all(width: 3, color: context.cSec),
                      borderRadius: BorderRadius.circular(32),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "LineChart",
                          style: GoogleFonts.ibmPlexMono(textStyle: context.h6),
                        ),
                        const SizedBox(height: 10),

                        SizedBox(height: 200, child: SimpleRadialChart()),
                      ],
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.all(8),
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border.all(width: 3, color: context.cSec),
                      borderRadius: BorderRadius.circular(32),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "\$2,320",
                          style: GoogleFonts.ibmPlexMono(textStyle: context.h3),
                        ),

                        const SizedBox(height: 10),

                        SizedBox(
                          child: ArbitraryGrid(
                            rows: 4,
                            cols: 9,
                            builder: (row, col) => Container(
                              width: 29,
                              height: 29,
                              margin: EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                color: context.cSec.withAlpha(
                                  90 + Random().nextInt(150),
                                ),
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                ],
              );
            }
            if (index == 2) {
              return Gallery();
            }
            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("You have", style: context.h1),
                        Text(
                          "long-term goals",
                          style: GoogleFonts.sawarabiMincho(
                            textStyle: context.h1.c(context.cSec),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Long-term goals focus on empowering users to achieve financial independence through automated and personalized planning.",
                          style: context.h7.w2,
                        ),

                        const SizedBox(height: 16),

                        GridView.count(
                          crossAxisCount: 2,
                          shrinkWrap: true,
                          mainAxisSpacing: 8,
                          crossAxisSpacing: 8,
                          childAspectRatio: 1.1,
                          physics: NeverScrollableScrollPhysics(),
                          children:
                              List.generate(4, (c) {
                                    return 1;
                                  })
                                  .asMap()
                                  .entries
                                  .map(
                                    (e) => Container(
                                      decoration: BoxDecoration(
                                        color: e.key == 0
                                            ? context.cSec
                                            : context.cSur3,
                                        borderRadius:
                                            BorderRadiusGeometry.circular(16),
                                      ),
                                      padding: EdgeInsets.all(16),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Current new worth",
                                            style: context.h8.c(
                                              e.key == 0
                                                  ? context.cOnSec
                                                  : context.cOnSur,
                                            ),
                                          ),
                                          Text(
                                            "\$25,981",
                                            style: context.h5.c(
                                              e.key == 0
                                                  ? context.cOnSec
                                                  : context.cOnSur,
                                            ),
                                          ),
                                          FilledButton(
                                            style: FilledButton.styleFrom(
                                              backgroundColor: context.cSur,
                                            ),
                                            onPressed: () {},
                                            child: Text(
                                              "Edit",
                                              style: context.h8,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                  .toList(),
                        ),

                        Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: context.cSec.withAlpha(50),
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.ac_unit_rounded),
                                  SizedBox(width: 8),
                                  Text(
                                    "You are good",
                                    style: GoogleFonts.sawarabiMincho(
                                      textStyle: context.h6,
                                    ),
                                  ),
                                  Spacer(),
                                  Icon(Icons.close),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text(
                                "We have checked your savings and it looks like you will win.",
                                style: context.h7.w3,
                              ),
                              const SizedBox(height: 8),
                              Stack(
                                alignment: Alignment.centerLeft,
                                children: [
                                  LinearProgressIndicator(
                                    value: .5,
                                    minHeight: 50,
                                    borderRadius: BorderRadius.circular(8),
                                    color: context.cSec,
                                    backgroundColor: context.cSec.withAlpha(40),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20,
                                    ),
                                    child: Text(
                                      "34%",
                                      style: context.h6.c(context.cOnSec),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 16),

                        Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: context.cSur3,
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(),
                                  SizedBox(width: 8),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Buy a house",
                                        style: GoogleFonts.sawarabiMincho(
                                          textStyle: context.h6,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text("Individual", style: context.h9),
                                    ],
                                  ),
                                  Spacer(),
                                  Icon(
                                    Icons.arrow_forward_ios_outlined,
                                    size: 12,
                                  ),
                                ],
                              ),

                              const SizedBox(height: 16),
                              LinearProgressIndicator(
                                value: .5,
                                minHeight: 4,
                                borderRadius: BorderRadius.circular(8),
                                color: context.cPri,
                                backgroundColor: context.cOnSur.withAlpha(40),
                              ),

                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("\$34034", style: context.h7.w3),
                                  Text("\$145054", style: context.h7.w3),
                                ],
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 16),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Hi, Luna',
                              style: GoogleFonts.ibmPlexMono(
                                textStyle: context.h4,
                              ),
                            ),
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(80),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'YOUR BALANCE',
                          style: GoogleFonts.ibmPlexMono(textStyle: context.h9),
                        ),

                        const SizedBox(height: 8),

                        Divider(),

                        const SizedBox(height: 8),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'YOUR MOST EXPENSES',
                              style: GoogleFonts.ibmPlexMono(
                                textStyle: context.h9,
                              ),
                            ),
                            Text(
                              'SEE ALL',
                              style: GoogleFonts.ibmPlexMono(
                                textStyle: context.h9,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 8),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'LATEST TRANSACTIONS',
                              style: GoogleFonts.ibmPlexMono(
                                textStyle: context.h9,
                              ),
                            ),
                            Text(
                              'SEE ALL',
                              style: GoogleFonts.ibmPlexMono(
                                textStyle: context.h9,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 8),

                        const Divider(height: 1),

                        ListTile(
                          contentPadding: EdgeInsets.symmetric(horizontal: 4),
                          dense: true,
                          leading: Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: context.cPri,
                              borderRadius: BorderRadius.circular(32),
                            ),
                            child: Icon(Icons.tiktok, color: context.cOnPri),
                          ),
                          title: Text(
                            'Movie Tickets',
                            style: GoogleFonts.ibmPlexMono(
                              textStyle: context.h8,
                            ),
                          ),
                          subtitle: Text(
                            '28 Apr',
                            style: GoogleFonts.ibmPlexMono(
                              textStyle: context.h9,
                            ),
                          ),
                          trailing: Text(
                            '\$12.5',
                            style: GoogleFonts.ibmPlexMono(
                              textStyle: context.h4,
                            ),
                          ),
                          onTap: () {},
                        ),

                        const SizedBox(height: 16),

                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          dense: true,
                          title: Text(
                            'Payment',
                            style: GoogleFonts.ibmPlexMono(
                              textStyle: context.h4,
                            ),
                          ),
                          subtitle: Text(
                            'Information',
                            style: GoogleFonts.ibmPlexMono(
                              textStyle: context.h4,
                            ),
                          ),
                          trailing: Icon(Icons.card_membership_sharp, size: 42),
                        ),

                        AsyncTextFormField(
                          valueParser: (value) => value,
                          valueFormatter: (value) => value,
                          validator: (value) {
                            if ("####-####-####-####".length != value.length) {
                              return "Invalid Card Number";
                            }
                            return null;
                          },
                          inputFormatters: [
                            MaskTextInputFormatter(
                              mask: "####-####-####-####",
                              initialText: "0987-1234-5678-9012",
                            ),
                          ],
                          initialValue: "0987-1234-5678-9012",
                          suffix: [Icon(Icons.view_in_ar_sharp)],
                          decoration: (asyncText, textCon) {
                            return InputDecoration(
                              labelText: 'CARD NUMBER',
                              hintText: "0987-1234-5678-9012",
                            );
                          },
                        ),

                        const SizedBox(height: 16),

                        AsyncTextFormField(
                          valueParser: (value) => value,
                          valueFormatter: (value) => value,
                          initialValue: "Magic fox",
                          asyncValidator: (value) async {
                            await Future.delayed(Duration(milliseconds: 300));
                            if (![
                              "Magic",
                              "Fox",
                              "Magic fox",
                            ].contains(value)) {
                              throw "$value not allowed";
                            }
                          },
                          validator: (value) {
                            return value.isEmpty
                                ? "Name cannot be empty"
                                : null;
                          },
                          decoration: (asyncText, textCon) {
                            return InputDecoration(labelText: 'NAME ON CARD');
                          },
                        ),

                        const SizedBox(height: 16),

                        Row(
                          children: [
                            Expanded(
                              child: AsyncTextFormField<DateTime>(
                                valueParser: (value) =>
                                    DateFormat('MMM yyyy').tryParse(value),
                                valueFormatter: (value) =>
                                    DateFormat('MMM yyyy').format(value),
                                onTap: (controller, onChanged) async {
                                  AsyncText.datetimeSelect(
                                    context,
                                    controller,
                                    onChanged,
                                    DateFormat('MMM yyyy'),
                                    DateTime(2024),
                                    DateTime(2026),
                                  );
                                },
                                decoration: (asyncText, textCon) {
                                  return InputDecoration(
                                    labelText: 'EXPIRY DATE',
                                    helperText: '',
                                  );
                                },
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: AsyncTextFormField<int>(
                                valueParser: (value) => int.tryParse(value),
                                valueFormatter: (value) => value.toString(),
                                inputFormatters: AsyncText.positiveIntFormatter,
                                validator: (int v) {
                                  if (v.toString().length != 3) {
                                    return "Length not 3";
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.number,
                                maxLength: 3,
                                password: true,
                                decoration: (asyncText, textCon) {
                                  return InputDecoration(
                                    labelText: 'CVV',
                                    helperText: '',
                                  );
                                },
                              ),
                            ),
                          ],
                        ),

                        // Double example
                        const SizedBox(height: 8),

                        FilledButton(
                          onPressed: () {
                            // Validate returns true if the form is valid, or false otherwise.
                            if (_formKey.currentState!.validate()) {
                              // If the form is valid, display a snackbar. In the real world,
                              // you'd often call a server or save the information in a database.
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Processing Data'),
                                ),
                              );
                            }
                          },
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Text(
                                'SAVE CHANGES',
                                style: context.h7.c(context.cOnPri).w3,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 8),

                        OutlinedButton(
                          onPressed: () {},
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Text(
                                'EDIT PAYMENT INFO',
                                style: context.h7.w3,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}

class SimpleLineChart extends StatelessWidget {
  const SimpleLineChart({super.key});

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        minY: 0,
        maxY: 10,
        gridData: FlGridData(show: false),
        borderData: FlBorderData(show: false),
        titlesData: FlTitlesData(
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        lineTouchData: LineTouchData(
          touchTooltipData: LineTouchTooltipData(
            tooltipBorder: BorderSide(),
            tooltipBorderRadius: BorderRadius.circular(8),
            getTooltipColor: (touchedSpot) {
              return Colors.transparent;
            },
            getTooltipItems: (List<LineBarSpot> touchedSpots) {
              return touchedSpots.map((spot) {
                return LineTooltipItem(
                  'X: ${spot.x.toStringAsFixed(1)}}',
                  TextStyle(
                    color: context.cOnSur,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                );
              }).toList();
            },
          ),
        ),
        lineBarsData: [
          LineChartBarData(
            curveSmoothness: .7,
            spots: const [
              FlSpot(0, 3),
              FlSpot(1, 4),
              FlSpot(2, 5),
              FlSpot(3, 3.1),
              FlSpot(4, 4.8),
              FlSpot(5, 7),
              FlSpot(6, 6.2),
            ],
            isCurved: true,
            color: context.cSec,
            barWidth: 3,
            dotData: FlDotData(show: true),
            belowBarData: BarAreaData(
              show: true,
              color: context.cSec.withAlpha(40),
            ),
          ),
        ],
      ),
    );
  }
}

class SimpleBarChart extends StatelessWidget {
  const SimpleBarChart({super.key});

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        maxY: 10,
        minY: 0,
        barTouchData: BarTouchData(
          enabled: true,
          touchTooltipData: BarTouchTooltipData(
            tooltipBorder: BorderSide(),
            tooltipBorderRadius: BorderRadius.circular(8),
            getTooltipColor: (touchedSpot) {
              return Colors.transparent;
            },
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              return BarTooltipItem(
                'Y: ${rod.toY.toStringAsFixed(1)}',
                TextStyle(color: context.cOnSur, fontWeight: FontWeight.bold),
              );
            },
          ),
        ),
        titlesData: FlTitlesData(
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, _) => Text('X${value.toInt()}'),
            ),
          ),
        ),
        gridData: FlGridData(show: false),
        borderData: FlBorderData(show: false),
        barGroups: _buildBarGroups(context),
      ),
    );
  }

  List<BarChartGroupData> _buildBarGroups(BuildContext context) {
    final values = [3.5, 5.0, 6.8, 4.2, 7.5];
    return List.generate(values.length, (i) {
      return BarChartGroupData(
        x: i,
        barRods: [
          BarChartRodData(
            toY: values[i],
            color: context.cSec,
            width: 16,
            borderRadius: BorderRadius.circular(1),
            backDrawRodData: BackgroundBarChartRodData(
              show: true,
              toY: 10,
              color: context.cSec.withAlpha(40),
            ),
          ),
          BarChartRodData(
            toY: values[values.length - i - 1],
            color: context.cTer,
            width: 16,
            borderRadius: BorderRadius.circular(1),
            backDrawRodData: BackgroundBarChartRodData(
              show: true,
              toY: 10,
              color: context.cTer.withAlpha(40),
            ),
          ),
        ],
      );
    });
  }
}

class SimpleRadialChart extends StatelessWidget {
  const SimpleRadialChart({super.key});

  @override
  Widget build(BuildContext context) {
    return PieChart(
      PieChartData(
        sectionsSpace: 2,
        centerSpaceRadius: 70,
        sections: _buildSections(),
        // pieTouchData: PieTouchData(touchCallback: (event, response) {}),
      ),
    );
  }

  List<PieChartSectionData> _buildSections() {
    final data = [
      {
        'value': 30.0,
        'color': const Color.fromARGB(255, 120, 73, 206),
        'title': 'Green',
      },
      {
        'value': 15.0,
        'color': const Color.fromARGB(255, 122, 6, 172),
        'title': 'Orange',
      },
      {
        'value': 15.0,
        'color': const Color.fromARGB(255, 158, 27, 239),
        'title': 'Red',
      },
    ];

    return data.map((e) {
      return PieChartSectionData(
        value: e['value'] as double,
        color: e['color'] as Color,
        title: '${(e['value'] as double).toStringAsFixed(0)}%',
        radius: 30,
        titleStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      );
    }).toList();
  }
}

class ArbitraryGrid extends StatelessWidget {
  final int rows;
  final int cols;
  final Widget Function(int row, int col) builder;

  const ArbitraryGrid({
    super.key,
    required this.rows,
    required this.cols,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(rows, (row) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(cols, (col) {
            return builder(row, col);
          }),
        );
      }),
    );
  }
}

class Gallery extends StatefulWidget {
  const Gallery({super.key});

  @override
  State<Gallery> createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  final ImagePicker _picker = ImagePicker();
  List<XFile> _selectedImages = [];

  Future<void> _pickImagesFromGallery() async {
    final List<XFile>? pickedFiles = await _picker.pickMultiImage();

    if (pickedFiles != null && pickedFiles.isNotEmpty) {
      setState(() {
        final existingPaths = _selectedImages.map((f) => f.path).toSet();
        final newFiles = pickedFiles.where(
          (f) => !existingPaths.contains(f.path),
        );
        _selectedImages.addAll(newFiles);
      });
    }
  }

  Future<void> _pickImageFromCamera() async {
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    if (photo != null) {
      setState(() {
        _selectedImages.add(photo);
      });
    }
  }

  void _removeImage(int index) {
    setState(() {
      _selectedImages.removeAt(index);
    });
  }

  void _goToUploadScreen() {
    if (_selectedImages.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select images first')),
      );
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton.extended(
            onPressed: _pickImageFromCamera,
            icon: const Icon(Icons.camera_alt),
            label: Text("Camera"),
          ),
          const SizedBox(height: 10),
          FloatingActionButton.extended(
            onPressed: _pickImagesFromGallery,
            icon: const Icon(Icons.photo),
            label: Text("Gallery"),
          ),
          const SizedBox(height: 10),
          if (_selectedImages.isNotEmpty)
            FloatingActionButton.extended(
              onPressed: _goToUploadScreen,
              icon: const Icon(Icons.cloud_upload),
              label: Text("Upload"),
            ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverGrid.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemCount: _selectedImages.length,
            itemBuilder: (context, index) {
              return Stack(
                fit: StackFit.expand,
                children: [
                  Image.file(
                    File(_selectedImages[index].path),
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: () => _removeImage(index),
                      child: Container(
                        color: Colors.black54,
                        padding: const EdgeInsets.all(2),
                        child: const Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
