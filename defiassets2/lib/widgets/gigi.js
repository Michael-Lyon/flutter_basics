Container(
        height: 100,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(30), topLeft: Radius.circular(30)),
          boxShadow: [
            BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.38), spreadRadius: 0, blurRadius: 10),
          ],
        ),
        child:  ClipRRect(
          borderRadius:  const BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
          child:   BottomNavigationBar(
            items: const[
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite), label: 'Favourite'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite), label: 'Favourite')
            ],
          ),
        ),
      ),