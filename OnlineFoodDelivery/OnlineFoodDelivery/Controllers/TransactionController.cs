using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using OnlineFoodDelivery.Model;
using System;
using System.Collections.Generic;
using System.IdentityModel.Tokens.Jwt;
using System.Linq;
using System.Reflection;
using System.Security.Claims;
using System.Threading.Tasks;

namespace OnlineFoodDelivery.Controllers
{
    [Authorize]
    [Route("api/[controller]")]
    [ApiController]
    public class TransactionController : ControllerBase
    {
        private readonly OrderDAL _orderDAL;
        private readonly UserDAL _userDAL;

        public TransactionController(OrderDAL orderDAL, UserDAL userDAL)
        {
            _orderDAL = orderDAL;
            _userDAL = userDAL;
        }

        [HttpPost]
        [Route("postCreateOrder")]
        public async Task<IActionResult> CreateOrder(Order order)
        {
            if (ModelState.IsValid)
            {
                if (ValidateTokenAndRole(1,out string userRole))
                {
                    // Perform role-specific actions here if needed

                    int orderId = await _orderDAL.CreateOrderAsync(order);
                    return Ok(orderId);
                }

                return Unauthorized(new { message = "Unauthorized access." });
            }
            return BadRequest(ModelState);
        }

        [HttpGet]
        [Route("getOrders")]
        public async Task<IActionResult> GetOrders()
        {
            if (ValidateTokenAndRole(2, out _))
            {
                var orders = await _orderDAL.GetOrdersAsync();
                return Ok(orders);
            }

            return Unauthorized(new { message = "Unauthorized access." });
        }

        [HttpPut("{id}")]
        public async Task<IActionResult> UpdateOrder(int id, Order order)
        {
            if (ModelState.IsValid)
            {
                if (ValidateTokenAndRole(3, out _))
                {
                    // Your update logic here

                    int affectedRows = await _orderDAL.UpdateOrderAsync(order);
                    if (affectedRows > 0)
                    {
                        return Ok("Order updated successfully.");
                    }
                    return NotFound("Order not found.");
                }

                return Unauthorized(new { message = "Unauthorized access." });
            }
            return BadRequest(ModelState);
        }

        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteOrder(int id)
        {
            if (ValidateTokenAndRole(4, out _))
            {
                int affectedRows = await _orderDAL.DeleteOrderAsync(id);
                if (affectedRows > 0)
                {
                    return Ok("Order deleted successfully.");
                }
                return NotFound("Order not found.");
            }

            return Unauthorized(new { message = "Unauthorized access." });
        }

        private bool ValidateTokenAndRole(int module, out string userRole)
        {
            userRole = null;

            var token = HttpContext.User.Identity as ClaimsIdentity;
            if (token != null && token.Claims != null)
            {
                var expirationClaim = token.Claims.FirstOrDefault(c => c.Type == ClaimTypes.Expiration);
                if (expirationClaim != null && DateTime.TryParse(expirationClaim.Value, out DateTime expirationDate))
                {
                    if (expirationDate < DateTime.UtcNow)
                    {
                        return false;
                    }
                }

                var roleClaim = token.Claims.FirstOrDefault(c => c.Type == ClaimTypes.Role);
                if (roleClaim != null)
                {
                    userRole = roleClaim.Value;

                    int roleId = (int)int.Parse(roleClaim.Value);
                    int moduleId = module;

                    int accessRightsCount = _userDAL.GetAccessRightsCountByRoleAndModule(roleId, moduleId);

                    if (accessRightsCount > 0)
                    {
                        return true;
                    }
                }
            }

            return false;
        }

    }
}
