// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:wt_action_button/action_button_definition.dart';
// import 'package:wt_action_button/model/action_info.dart';
// import 'package:wt_app_scaffold/app_platform/scaffold_app_dsl.dart';
// import 'package:wt_app_scaffold/app_scaffolds.dart';
// import 'package:wt_app_scaffold/models/app_scaffold_page_context.dart';
// import 'package:wt_app_scaffold/models/page_info.dart';
// import 'package:wt_app_scaffold/scaffolds/page/common/app_scaffold_page_content.dart';
// import 'package:wt_app_scaffold/scaffolds/page/common/app_scaffold_page_footer.dart';
// import 'package:wt_app_scaffold/scaffolds/page/common/app_scaffold_page_header.dart';
// import 'package:wt_app_scaffold/scaffolds/page/page_definition_scaffold/page/app_scaffold_page_content.dart';
// import 'package:wt_app_scaffold/scaffolds/page/page_definition_scaffold/page/app_scaffold_page_footer.dart';
// import 'package:wt_app_scaffold/scaffolds/page/page_definition_scaffold/page/app_scaffold_page_header.dart';
// import 'package:wt_logging/wt_logging.dart';
//
// void main() {
//   const template = PageDefinition(
//     pageInfo: PageInfo(
//       title: 'Template',
//       name: 'template',
//       icon: Icons.abc,
//     ),
//   );
//
//   final pageOneDef = TestOneScreen.createPageDefinition(template);
//   final pageTwoDef = TestTwoScreen.createPageDefinition(template);
//
//   runMyApp(
//     asPlainApp(
//       MaterialApp(
//         debugShowCheckedModeBanner: false,
//         home: Scaffold(
//           body: Consumer(
//             builder: (context, ref, ___) {
//               final buttonOne = ref.read(TestOneAction.provider);
//               return Center(
//                 child: ListView(
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         buttonOne.component(),
//                         ElevatedButton(
//                           onPressed: () {
//                             ref
//                                 .read(ref.read(TestOneAction.provider).progress.notifier)
//                                 .error('Something went wrong :-(');
//                           },
//                           child: const Text('Simulate Error'),
//                         )
//                       ],
//                     ),
//                     pageOneDef.createActionBar(ref),
//                     AppScaffoldPageContent(
//                       body: const Center(
//                         child: Text(':-)'),
//                       ),
//                       footerBuilder: (context) => pageOneDef.createActionBar(ref),
//                     ),
//                     AppScaffoldPageFooter(
//                       controlsButton: IconButton(
//                         onPressed: () {},
//                         icon: const Icon(FontAwesomeIcons.gear),
//                       ),
//                       actionsBar: pageOneDef.createActionBar(ref),
//                       homeButton: pageOneDef.createHomeLink(ref),
//                     ),
//                     AppScaffoldPageContent(
//                       header: AppScaffoldPageHeader(
//                         icon: Icon(pageOneDef.pageInfo.icon),
//                         title: ColoredBox(
//                           color: Colors.yellow,
//                           child: Text(
//                             pageOneDef.pageInfo.tabTitle,
//                             textAlign: TextAlign.left,
//                           ),
//                         ),
//                         indicators: Row(
//                           children: pageOneDef.actionsProviders
//                               .map(
//                                 (provider) => ref.read(provider).statusIcon(),
//                               )
//                               .toList(),
//                         ),
//                         // indicators: pageDefinition.createIndicatorBar(ref),
//                       ),
//                       body: Center(
//                         child: Text(pageOneDef.pageInfo.title),
//                       ),
//                       footerBuilder: (context) => AppScaffoldPageFooter(
//                         controlsButton: IconButton(
//                           onPressed: () {
//                             Scaffold.of(context).openDrawer();
//                           },
//                           icon: const Icon(FontAwesomeIcons.gear),
//                         ),
//                         actionsBar: pageOneDef.createActionBar(ref),
//                         homeButton: pageOneDef.createHomeLink(ref),
//                       ),
//                     ),
//                     pageOneDef.createPageContent(
//                       AppScaffoldPageContext(
//                         context: context,
//                         page: pageOneDef,
//                         ref: ref,
//                       ),
//                     ),
//                     pageTwoDef.createPageContent(
//                       AppScaffoldPageContext(
//                         context: context,
//                         page: pageTwoDef,
//                         ref: ref,
//                       ),
//                     ),
//                   ]
//                       .map((w) => Container(
//                             height: w.runtimeType == AppScaffoldPageContent ? 300 : 100,
//                             decoration: BoxDecoration(
//                               border: Border.all(color: Colors.grey.shade300),
//                             ),
//                             child: w,
//                           ))
//                       .toList(),
//                 ),
//               );
//             },
//           ),
//         ),
//       ),
//     ),
//   );
// }
//
// mixin TestOneScreen {
//   static const info = PageInfo(
//     title: 'Test One Screen',
//     tabTitle: 'Test One',
//     name: 'testOneScreen',
//     icon: Icons.map,
//   );
//
//   static PageDefinition createPageDefinition(PageDefinition template) {
//     return template.copyWith(
//       pageInfo: info,
//       actionProviders: [
//         TestOneAction.provider,
//       ],
//     );
//   }
// }
//
// mixin TestTwoScreen {
//   static const info = PageInfo(
//     title: 'Test Two Screen',
//     tabTitle: 'Test Two',
//     name: 'testTwoScreen',
//     icon: Icons.map,
//   );
//
//   static PageDefinition createPageDefinition(PageDefinition template) {
//     return template.copyWith(
//       pageInfo: info,
//       actionProviders: [
//         TestTwoAction.provider,
//         TestTwoAction.provider,
//         TestOneAction.provider,
//         TestTwoAction.provider,
//         TestTwoAction.provider,
//       ],
//     );
//   }
// }
//
// class TestOneAction extends ActionButtonDefinition {
//   static final log = logger(TestOneAction, level: Level.debug);
//
//   static final provider = Provider(
//     name: 'Test One Action',
//     (ref) {
//       log.d('====>>>> Creating: TestOneAction.provider');
//       return TestOneAction._(ref);
//     },
//   );
//
//   TestOneAction._(super.ref)
//       : super(
//           actionInfo: ActionInfo(
//             label: 'Test One',
//             tooltip: 'Test One',
//             icon: FontAwesomeIcons.car,
//           ),
//         );
//
//   @override
//   Future<void> execute() async {
//     final notifier = ref.read(progress.notifier);
//     notifier.run(
//       () {
//         simulate('----Test One Executing', logger: log);
//         notifier.error('Error executing Test One');
//       },
//     );
//   }
// }
//
// class TestTwoAction extends ActionButtonDefinition {
//   static final log = logger(TestOneAction, level: Level.debug);
//
//   static final provider = Provider(
//     name: 'Test Two Action',
//     (ref) {
//       log.d('====>>>> Creating: TestTwoAction.provider');
//       return TestTwoAction._(ref);
//     },
//   );
//
//   TestTwoAction._(super.ref)
//       : super(
//           actionInfo: ActionInfo(
//             label: 'Test Two',
//             tooltip: 'Test Two',
//             icon: FontAwesomeIcons.tractor,
//           ),
//         );
//
//   @override
//   Future<void> execute() async {
//     final notifier = ref.read(progress.notifier);
//     notifier.run(
//       () {
//         simulate('----Test Two Executing', logger: log);
//         notifier.error('Error executing Two One');
//       },
//     );
//   }
// }
