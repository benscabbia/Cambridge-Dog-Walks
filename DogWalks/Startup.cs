using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(DogWalks.Startup))]
namespace DogWalks
{
    public partial class Startup {
        public void Configuration(IAppBuilder app) {
            ConfigureAuth(app);
        }
    }
}
