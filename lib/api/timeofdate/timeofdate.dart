

  String listInString(List <String> mylist){
    String allTime= '';
    for (int i = 0; i <= mylist.length - 1; i++){
      allTime = '$allTime ${mylist[i].toString()}';
    }
    return allTime ;
  }

