import 'package:fluent_ui/fluent_ui.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FluentApp(
      theme: ThemeData.dark(),
      title: 'Flutter Demo',
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final myController = TextEditingController();
  int _counter = 0;
  int index = 0;
  int tabindex = 0;
  int tabs = 3;
  String title = "Bye";
  double _sliderValue = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return NavigationView(
      pane: NavigationPane(
        onChanged: (ind) {
          index = ind;
          setState(() {});
        },
        displayMode: PaneDisplayMode.compact,
        items: [
          PaneItem(
            icon: const Icon(FluentIcons.code),
            title: const Text("Code"),
          ),
          PaneItem(
            icon: const Icon(FluentIcons.user_window),
            title: const Text("Windows"),
          ),
          PaneItem(
            icon: const Icon(FluentIcons.tab),
            title: const Text("Title"),
          ),
          PaneItem(
            icon: const Icon(FluentIcons.message),
            title: const Text("Notification"),
          ),
        ],
      ),
      content: NavigationBody(
        transitionBuilder: (child, animation) =>
            DrillInPageTransition(child: child, animation: animation),
        index: index,
        children: [
          ScaffoldPage(
            content: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'You have pushed the button this many times:',
                ),
                Text(
                  '$_counter',
                ),
                FilledButton(
                    child: const Text("Increase"), onPressed: _incrementCounter)
              ],
            ),
          ),
          ScaffoldPage(
            content: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
                ),
                TextBox(
                  placeholderStyle: TextStyle(
                      color: Colors.blue, fontWeight: FontWeight.w700),
                  controller: myController,
                  header: "YO",
                  placeholder: "YOUR NOTES",
                  onSubmitted: (value) {
                    setState(() {
                      title = value;
                      myController.clear();
                    });
                  },
                ),
                SizedBox(
                  height: 100,
                ),
                Slider(
                  max: 100,
                  value: _sliderValue,
                  onChanged: (v) => setState(() => _sliderValue = v),
                  label: '${_sliderValue.toInt()}',
                ),
              ],
            ),
          ),
          TabView(
            currentIndex: tabindex,
            onChanged: (index) => setState(() => tabindex = index),
            onNewPressed: () {
              setState(() => tabs++);
            },
            tabs: List.generate(tabs, (index) {
              return Tab(
                  text: Text('Tab ${index + 1}  '),
                  onClosed: () {
                    setState(() => tabs--);
                    if (tabindex > tabs - 1) tabindex--;
                  });
            }),
            bodies: List.generate(
              tabs,
              (index) => Container(
                color: index.isEven ? Colors.red : Colors.yellow,
              ),
            ),
          ),
          ScaffoldPage(
            content: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FilledButton(
                    child: Text("Press Me"),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return ContentDialog(
                            title: Text('No WiFi connection'),
                            content:
                                Text('Check your connection and try again'),
                            actions: [
                              Button(
                                  child: Text('Ok'),
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return ContentDialog(
                                            title: Text(
                                                "Lmao This Just a fake Context"),
                                            content: Text(
                                                "You probably still have internet"),
                                            actions: [
                                              Button(
                                                child: Text("Close"),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                  Navigator.pop(context);
                                                },
                                              )
                                            ],
                                          );
                                        });
                                  }),
                            ],
                          );
                        },
                      );
                    }),
                SizedBox(
                  height: 100,
                ),
                FilledButton(
                    child: Text("Press me too"),
                    onPressed: () {
                      showSnackbar(
                        context,
                        Snackbar(
                          content: Text('Lmao NOOB'),
                        ),
                      );
                    })
              ],
            ),
          )
        ],
      ),
    );
  }
}
