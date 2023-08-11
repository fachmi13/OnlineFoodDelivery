namespace OnlineFoodDelivery.Model
{
    public class ApiLog
    {
        public int Id { get; set; }
        public string Endpoint { get; set; }
        public string Method { get; set; }
        public string RequestBody { get; set; }
        public string ResponseBody { get; set; }
        public DateTime LogTime { get; set; }
    }

    public class ErrorLog
    {
        public int Id { get; set; }
        public string Endpoint { get; set; }
        public string ErrorMessage { get; set; }
        public string StackTrace { get; set; }
        public DateTime LogTime { get; set; }
    }
}
