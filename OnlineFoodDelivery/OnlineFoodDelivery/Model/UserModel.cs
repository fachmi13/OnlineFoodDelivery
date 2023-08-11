namespace OnlineFoodDelivery.Model
{
    public class UserModel
    {
        public int Id { get; set; }
        public string Username { get; set; }
        public string Password { get; set; }
        public string Role { get; set; }
    }
    public class RoleModel
    {
        public int Id { get; set; }
        public string RoleName { get; set; }
    }

    public class ModuleModel
    {
        public int Id { get; set; }
        public string ModuleName { get; set; }
    }
}
