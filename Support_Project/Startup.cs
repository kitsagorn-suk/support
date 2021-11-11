using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(Support_Project.Startup))]
namespace Support_Project
{
    public partial class Startup {
        public void Configuration(IAppBuilder app) {
            ConfigureAuth(app);
        }
    }
}
