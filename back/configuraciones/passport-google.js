require("dotenv").config();
// configuraciones de axios
const axios = require("./axios");
const seguridad = require("../middlewares/seguridad");
const passport = require("passport");
var GoogleStrategy = require("passport-google-oauth20");
const { empty } = require("statuses");
const cors = require("cors");
passport.use(cors());
const storage = require("sessionstorage");

passport.use(
  new GoogleStrategy(
    {
      clientID: process.env.GOOGLE_CLIENT_ID,
      clientSecret: process.env.GOOGLE_CLIENT_SECRET,
      callbackURL: `http://${process.env.HOST}/api-back/callback`,
    },
    async function (request, accessToken, refreshToken, profile, done) {
      // console.log(`user linke ${JSON.stringify(profile)}`);
      let perfilUser = "";
      perfilUser = {
        idGoogle: profile.id,
        user: profile.emails[0]["value"],
        nombreMostrar: profile.displayName,
        imagen: profile.photos[0]["value"],
      };
      // console.log(`perfil: ${perfilUser.user} and axios ${axios}`);
      return await axios
        .get(`Usuarios?user=eq.${perfilUser.user}`, {
          headers: {
            accept: "application/json",
          },
        })
        .then((response) => {
          let user = response.data[0];
          if (user.length === 0) {
            console.log(`is null `);
          } else {
            //console.log(`is llega ${JSON.stringify(user.id)}`);
            user.token = "";
            let token = seguridad.generateAccessToken(user);
            console.log(`user ${user.id}`);
            // const update = `{ "token": "${token}", "imagen": "${perfilUser.imagen}"  }`;
            const update = `{ "token": "${token}", "imagen": "${perfilUser.imagen}"  }`;
            axios
              .patch(`Usuarios?id=eq.${user.id}`, JSON.parse(update), {
                headers: {
                  accept: "application/json",
                },
              })
              .then((response) => {
                storage.setItem("jwt", token);
                return done(null, user);
              })
              .catch((error) => {
                return error;
              });
          }
        })
        .catch(function (error) {
          console.log(`error ${error}`);
        });
    }
  )
);
