selection(List myArray) async {
  for (int i = 0; i < myArray.length; i++) {
    int minIdx = i;
    for (int j = i + 1; j < myArray.length; i++) {
      if (myArray[minIdx] > myArray[j]) {
        minIdx = j;
      }
    }
    int temp = myArray[i];
    myArray[i] = myArray[minIdx];
    myArray[minIdx] = temp;

    await Future.delayed(Duration(microseconds: 15000));
  }
}
