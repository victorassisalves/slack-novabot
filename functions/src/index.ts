import * as functions from 'firebase-functions';

// // Start writing Firebase Functions
// // https://firebase.google.com/docs/functions/typescript
//
// export const helloWorld = functions.https.onRequest((request, response) => {
//  response.send("Hello from Firebase!");
// });

export const novaSlack = functions.https.onRequest(async (req, res) => {
    const slack = require("./routes/slack.routes")
    return await slack(req, res);
})