const { fetch } = require('node-fetch')

module.exports = class Rails {
  constructor() {
    console.log("new Rails")
  }

  proxy(message) {
    return new Promise((resolve, reject) => {
      fetch('https//localhost:3200/rtm', {
        method: 'POST',
        body: JSON.stringify(message),
        headers: { 'Content-Type': 'application/json' }
      })
      .then(res => res.json())
      .then(resolve)
      .catch(reject);
    })
  }
};