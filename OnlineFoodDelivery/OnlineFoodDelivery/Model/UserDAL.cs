using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using Microsoft.Extensions.Configuration;

namespace OnlineFoodDelivery.Model
{
    public class UserDAL
    {
        private readonly IConfiguration _configuration;

        public UserDAL(IConfiguration configuration)
        {
            _configuration = configuration;
        }

        public UserModel GetUserByUsernameAndPassword(string username, string password)
        {
            using (var connection = new SqlConnection(_configuration.GetConnectionString("DefaultConnection")))
            {
                connection.Open();

                var query = "SELECT * FROM Users WHERE Username = @Username AND Password = @Password";
                using (var command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@Username", username);
                    command.Parameters.AddWithValue("@Password", password);

                    using (var reader = command.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            return new UserModel
                            {
                                Id = Convert.ToInt32(reader["Id"]),
                                Username = reader["Username"].ToString(),
                                Password = reader["Password"].ToString(),
                                Role = reader["Role"].ToString()
                            };
                        }
                        return null;
                    }
                }
            }
        }
        public int GetAccessRightsCountByRoleAndModule(int roleId, int moduleId)
        {
            using (var connection = new SqlConnection(_configuration.GetConnectionString("DefaultConnection")))
            {
                connection.Open();

                var query = "SELECT COUNT(1) FROM RoleAccessMapping WHERE IdRole = @IdRole AND IdModules = @IdModules";
                using (var command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@IdRole", roleId);
                    command.Parameters.AddWithValue("@IdModules", moduleId);

                    int count = (int)command.ExecuteScalar();
                    return count;
                }
            }
        }

    }
}
