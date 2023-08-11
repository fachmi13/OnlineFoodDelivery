using Microsoft.Extensions.Configuration;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Threading.Tasks;
using Dapper;

namespace OnlineFoodDelivery.Model
{
    public class OrderDAL
    {
        private readonly IConfiguration _configuration;

        public OrderDAL(IConfiguration configuration)
        {
            _configuration = configuration;
        }

        public async Task<int> CreateOrderAsync(Order order)
        {
            using (var connection = new SqlConnection(_configuration.GetConnectionString("DefaultConnection")))
            {
                await connection.OpenAsync();

                var parameters = new DynamicParameters();
                parameters.Add("@CustomerName", order.CustomerName);

                int orderId = await connection.ExecuteScalarAsync<int>("InsertOrder", parameters, commandType: CommandType.StoredProcedure);

                foreach (var item in order.Items)
                {
                    parameters = new DynamicParameters();
                    parameters.Add("@OrderId", orderId);
                    parameters.Add("@ProductId", item.ProductId);
                    parameters.Add("@ProductName", item.ProductName);
                    parameters.Add("@Price", item.Price);
                    parameters.Add("@Quantity", item.Quantity);

                    await connection.ExecuteAsync("InsertCartItem", parameters, commandType: CommandType.StoredProcedure);
                }

                return orderId;
            }
        }

        public async Task<IEnumerable<Order>> GetOrdersAsync()
        {
            using (var connection = new SqlConnection(_configuration.GetConnectionString("DefaultConnection")))
            {
                await connection.OpenAsync();

                var ordersDictionary = new Dictionary<int, Order>();

                var query = @"
                    SELECT o.Id, o.CustomerName, o.OrderDate,
                           c.Id, c.ProductId, c.ProductName, c.Price, c.Quantity
                    FROM Orders o
                    LEFT JOIN CartItems c ON o.Id = c.OrderId";

                var result = await connection.QueryAsync<Order, CartItem, Order>(
                    query,
                    (order, cartItem) =>
                    {
                        if (!ordersDictionary.TryGetValue(order.Id, out var orderEntry))
                        {
                            orderEntry = order;
                            orderEntry.Items = new List<CartItem>();
                            ordersDictionary.Add(order.Id, orderEntry);
                        }

                        if (cartItem != null)
                        {
                            orderEntry.Items.Add(cartItem);
                        }

                        return orderEntry;
                    },
                    splitOn: "Id");

                return result.Distinct();
            }
        }
        public async Task<int> UpdateOrderAsync(Order order)
        {
            using (var connection = new SqlConnection(_configuration.GetConnectionString("DefaultConnection")))
            {
                await connection.OpenAsync();

                using (var transaction = connection.BeginTransaction())
                {
                    var parameters = new DynamicParameters();
                    parameters.Add("@Id", order.Id);
                    parameters.Add("@CustomerName", order.CustomerName);

                    int affectedRows = 1;//await connection.ExecuteAsync("UpdateOrder", parameters, transaction, commandType: CommandType.StoredProcedure);

                    if (affectedRows > 0)
                    {
                        // Update the associated cart items
                        foreach (var cartItem in order.Items)
                        {
                            var cartItemParameters = new DynamicParameters();
                            cartItemParameters.Add("@OrderId", order.Id);
                            cartItemParameters.Add("@ProductId", cartItem.ProductId);
                            cartItemParameters.Add("@Quantity", cartItem.Quantity);
                            cartItemParameters.Add("@Price", cartItem.Price);

                            await connection.ExecuteAsync("UpdateCartItem", cartItemParameters, transaction, commandType: CommandType.StoredProcedure);
                        }

                        transaction.Commit();
                        return affectedRows;
                    }
                    else
                    {
                        transaction.Rollback();
                        return 0;
                    }
                }
            }
        }


        public async Task<int> DeleteOrderAsync(int orderId)
        {
            using (var connection = new SqlConnection(_configuration.GetConnectionString("DefaultConnection")))
            {
                await connection.OpenAsync();

                var parameters = new DynamicParameters();
                parameters.Add("@Id", orderId);

                return await connection.ExecuteAsync("DeleteOrder", parameters, commandType: CommandType.StoredProcedure);
            }
        }
    }
}
