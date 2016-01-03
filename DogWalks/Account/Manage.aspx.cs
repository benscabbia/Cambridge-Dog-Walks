using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Web;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.EntityFramework;
using Microsoft.AspNet.Identity.Owin;
using Microsoft.Owin.Security;
using Owin;
using DogWalks.Models;
using DogWalks.DAL;
using Microsoft.AspNet.Identity;

namespace DogWalks.Account
{
    public partial class Manage : System.Web.UI.Page
    {
        protected string SuccessMessage
        {
            get;
            private set;
        }

        private bool HasPassword(ApplicationUserManager manager)
        {
            return manager.HasPassword(User.Identity.GetUserId());
        }

        public bool HasPhoneNumber { get; private set; }

        public bool TwoFactorEnabled { get; private set; }

        public bool TwoFactorBrowserRemembered { get; private set; }

        public int LoginsCount { get; set; }

        protected void Page_Load()
        {
          Form.Enctype = "multipart/form-data";

            var manager = Context.GetOwinContext().GetUserManager<ApplicationUserManager>();

            HasPhoneNumber = String.IsNullOrEmpty(manager.GetPhoneNumber(User.Identity.GetUserId()));

            // Enable this after setting up two-factor authentientication
            //PhoneNumber.Text = manager.GetPhoneNumber(User.Identity.GetUserId()) ?? String.Empty;

            TwoFactorEnabled = manager.GetTwoFactorEnabled(User.Identity.GetUserId());

            LoginsCount = manager.GetLogins(User.Identity.GetUserId()).Count;

            var authenticationManager = HttpContext.Current.GetOwinContext().Authentication;

            if (!IsPostBack)
            {
              //on first load, load all data into textboxes
              using (var db = new WalkContext())
              {
                var currentUserID = User.Identity.GetUserId();
                UserProfile userProfile = (from u in db.UserProfiles
                                           where u.FKUserID == currentUserID
                                           select u).Single();

                imgProfile.ImageUrl = !string.IsNullOrEmpty(userProfile.ProfilePicture) ? userProfile.ProfilePicture : string.Empty;            
                tbFirstName.Text = userProfile.FirstName;
                tbLastName.Text = userProfile.LastName;
                tbAddress.Text = userProfile.Address;
                tbPostcode.Text = userProfile.Postcode;
                tbAboutMe.Text = userProfile.AboutMe;
                 
              }

              // Determine the sections to render
              //if (HasPassword(manager))
              //{
              //    ChangePassword.Visible = true;
              //}
              //else
              //{
              //    CreatePassword.Visible = true;
              //    ChangePassword.Visible = false;
              //}

                // Render success message
                var message = Request.QueryString["m"];
                if (message != null)
                {
                    // Strip the query string from action
                    Form.Action = ResolveUrl("~/Account/Manage");

                    SuccessMessage =
                        message == "ChangePwdSuccess" ? "Your password has been changed."
                        : message == "SetPwdSuccess" ? "Your password has been set."
                        : message == "RemoveLoginSuccess" ? "The account was removed."
                        : message == "AddPhoneNumberSuccess" ? "Phone number has been added"
                        : message == "RemovePhoneNumberSuccess" ? "Phone number was removed"
                        : String.Empty;
                    successMessage.Visible = !String.IsNullOrEmpty(SuccessMessage);
                }
            }
        }


        private void AddErrors(IdentityResult result)
        {
            foreach (var error in result.Errors)
            {
                ModelState.AddModelError("", error);
            }
        }

        // Remove phonenumber from user
        protected void RemovePhone_Click(object sender, EventArgs e)
        {
            var manager = Context.GetOwinContext().GetUserManager<ApplicationUserManager>();
            var signInManager = Context.GetOwinContext().Get<ApplicationSignInManager>();
            var result = manager.SetPhoneNumber(User.Identity.GetUserId(), null);
            if (!result.Succeeded)
            {
                return;
            }
            var user = manager.FindById(User.Identity.GetUserId());
            if (user != null)
            {
                signInManager.SignIn(user, isPersistent: false, rememberBrowser: false);
                Response.Redirect("/Account/Manage?m=RemovePhoneNumberSuccess");
            }
        }

        // DisableTwoFactorAuthentication
        protected void TwoFactorDisable_Click(object sender, EventArgs e)
        {
            var manager = Context.GetOwinContext().GetUserManager<ApplicationUserManager>();
            manager.SetTwoFactorEnabled(User.Identity.GetUserId(), false);

            Response.Redirect("/Account/Manage");
        }

        //EnableTwoFactorAuthentication 
        protected void TwoFactorEnable_Click(object sender, EventArgs e)
        {
            var manager = Context.GetOwinContext().GetUserManager<ApplicationUserManager>();
            manager.SetTwoFactorEnabled(User.Identity.GetUserId(), true);

            Response.Redirect("/Account/Manage");
        }

        protected void btUpdate_Click(object sender, EventArgs e)
        {
          using (var db = new WalkContext())
          {
            var currentUserID = User.Identity.GetUserId();

            UserProfile userProfile = (from u in db.UserProfiles
                                       where u.FKUserID == currentUserID
                                       select u).Single();

            userProfile.FirstName = tbFirstName.Text;
            userProfile.LastName = tbLastName.Text;
            userProfile.Address = tbAddress.Text;
            userProfile.Postcode = tbPostcode.Text;
            userProfile.AboutMe = tbAboutMe.Text;

            //must add logic to delete old picture
            HttpPostedFile myPicture = Request.Files.Count > 0 ? Request.Files[0] : null;

            if (myPicture != null && myPicture.ContentLength > 0 )
            {
              string virtualFolder = "~/Account/ProfilePicts/";
              string physicalFolder = Server.MapPath(virtualFolder);
              string fileName = Guid.NewGuid().ToString();
              string extension = System.IO.Path.GetExtension(myPicture.FileName);
              myPicture.SaveAs(System.IO.Path.Combine(physicalFolder, fileName + extension));  //save image on local
              userProfile.ProfilePicture = virtualFolder + fileName + extension; //set picture url                                
            }
            db.SaveChanges();

            imgProfile.ImageUrl = !string.IsNullOrEmpty(userProfile.ProfilePicture) ? userProfile.ProfilePicture : string.Empty;            
          }
        }
    }
}