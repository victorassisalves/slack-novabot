const admin = require('firebase-admin');
admin.initializeApp({
  credential: admin.credential.applicationDefault()
});

export const db = admin.firestore();