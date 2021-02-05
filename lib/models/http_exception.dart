class HttpException  implements Exception{// implements all the functions of Exceptions

  final String message;
  HttpException(this.message);

  @override
  String toString(){
    // return super.toString();//returns Instance of HtpException
    return message;
  }
}