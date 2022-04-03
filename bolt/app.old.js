
const { App, directMention } = require('@slack/bolt');
require('dotenv').config()
const fetch = (...args) => import('node-fetch').then(({default: fetch}) => fetch(...args));

// Initializes your app with your bot token and signing secret
const app = new App({
  token: process.env.SLACK_BOT_TOKEN,
  signingSecret: process.env.SLACK_SIGNING_SECRET,
  appToken: process.env.SLACK_APP_TOKEN,
  socketMode: true,
  port: process.env.PORT || 8000
})


app.message(/^\!todo/, async ({ message, say }) => {
  // say() sends a message to the channel where the event was triggered
  console.log("Message Get")
  fetch(process.env.RAILS_RTM_URL, {
    method: 'POST',
    body: JSON.stringify(message),
    headers: { 'Content-Type': 'application/json', 'Accept': 'application/json'}
  })
  .then(res => res.json())
  .then(json => {
    say(json.reply)
  })
  .catch(err => say("Error: " + err));
});


app.message(directMention(), async ({ message, say }) => {
  say(`Hello ${message.user}, we're talking in ${message.channel}\nMake a todo:   \`!todo do a thing tomorrow\``)
});

(async () => {
  // Start your app
  await app.start(process.env.PORT || 8000);

  console.log('⚡️ Bolt app is running!');
})();

