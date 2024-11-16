class NetworkResponse {
 final bool isSuccess;
 final int statusCode;
 dynamic statusData;
 dynamic errorMessage;

 NetworkResponse({
   required this.isSuccess,
   required this.statusCode,
   this.statusData,
   this.errorMessage = 'Something went wrong!' });
}