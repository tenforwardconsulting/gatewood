import { JSO } from "jso"
module.exports = class Basecamp {
  constructor() {
    console.log("new Basecamp")
  }

  oauthClient() {
    let client = new JSO({
      providerID: "google",
      client_id: "541950296471.apps.googleusercontent.com",
      redirect_uri: "http://localhost:8080/", // The URL where you is redirected back, and where you perform run the callback() function.
      authorization: "https://accounts.google.com/o/oauth2/auth",
      scopes: { request: ["https://www.googleapis.com/auth/userinfo.profile"]}
    })
    return client
  }

  area() {

  }
};