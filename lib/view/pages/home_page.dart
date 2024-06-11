import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:notes_app/view/pages/add_note_page.dart';

class HomePage extends HookWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final scrollController = useScrollController();
    final opacityState = useState(1.0);

    void changeTitleOpacity() {
      opacityState.value =
          1 - (min(150, scrollController.offset.toInt()) / 150);
    }

    useEffect(() {
      scrollController.addListener(changeTitleOpacity);

      return () {
        scrollController.removeListener(changeTitleOpacity);
      };
    }, []);

    void openAddNotePage(BuildContext context) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const AddNotePage(),
        ),
      );
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      body: CustomScrollView(
        controller: scrollController,
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.black,
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: Center(
              child: Opacity(
                opacity: opacityState.value,
                child: const Text(
                  'Notes',
                  style: TextStyle(
                    fontSize: 32,
                  ),
                ),
              ),
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(60),
              child: Container(
                height: 60,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.menu),
                    ),
                    Expanded(
                      child: Opacity(
                        opacity: 1 - opacityState.value,
                        child: const Text(
                          'Notes',
                          style: TextStyle(
                            fontSize: 22,
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.search),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.more_vert),
                    )
                  ],
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverGrid.builder(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 150,
                crossAxisSpacing: 16,
                mainAxisSpacing: 32,
                childAspectRatio: 1 / 1.5,
              ),
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[900],
                    borderRadius: BorderRadius.circular(16),
                  ),
                );
              },
            ),
          )
        ],
      ),
      floatingActionButton: Builder(builder: (context) {
        return FloatingActionButton(
          onPressed: () => openAddNotePage(context),
          child: const Icon(Icons.add),
        );
      }),
    );
  }
}
