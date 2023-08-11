using Serilog;
using System;
using System.Data.SqlClient;
using OnlineFoodDelivery.Model;

namespace OnlineFoodDelivery.lib
{
    public class ApiLogger
    {
        private readonly Serilog.ILogger _logger;
        private readonly string _connectionString; // Inject the connection string

        public ApiLogger(string connectionString)
        {
            _connectionString = connectionString;

            _logger = new LoggerConfiguration()
                .WriteTo.File("log.txt", rollingInterval: RollingInterval.Day)
                .CreateLogger();
        }

        public void LogRequest(string endpoint, string method, string requestBody)
        {
            _logger.Information($"Request to {endpoint} [{method}] - Body: {requestBody}");
            SaveApiLog(endpoint, method, requestBody, null);
        }

        public void LogResponse(string endpoint, string responseBody)
        {
            _logger.Information($"Response from {endpoint} - Body: {responseBody}");
            SaveApiLog(endpoint, null, null, responseBody);
        }

        public void LogError(string endpoint, Exception exception)
        {
            _logger.Error(exception, $"Error in {endpoint}");
            SaveErrorLog(endpoint, exception.Message, exception.StackTrace);
        }

        private void SaveApiLog(string endpoint, string method, string requestBody, string responseBody)
        {
            using (var connection = new SqlConnection(_connectionString))
            {
                connection.Open();
                var query = "INSERT INTO ApiLogs (Endpoint, Method, RequestBody, ResponseBody, LogTime) VALUES (@Endpoint, @Method, @RequestBody, @ResponseBody, @LogTime)";
                using (var command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@Endpoint", endpoint);
                    command.Parameters.AddWithValue("@Method", method);
                    command.Parameters.AddWithValue("@RequestBody", requestBody);
                    command.Parameters.AddWithValue("@ResponseBody", responseBody);
                    command.Parameters.AddWithValue("@LogTime", DateTime.Now);

                    command.ExecuteNonQuery();
                }
            }
        }

        private void SaveErrorLog(string endpoint, string errorMessage, string stackTrace)
        {
            using (var connection = new SqlConnection(_connectionString))
            {
                connection.Open();
                var query = "INSERT INTO ErrorLogs (Endpoint, ErrorMessage, StackTrace, LogTime) VALUES (@Endpoint, @ErrorMessage, @StackTrace, @LogTime)";
                using (var command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@Endpoint", endpoint);
                    command.Parameters.AddWithValue("@ErrorMessage", errorMessage);
                    command.Parameters.AddWithValue("@StackTrace", stackTrace);
                    command.Parameters.AddWithValue("@LogTime", DateTime.Now);

                    command.ExecuteNonQuery();
                }
            }
        }
    }
}
