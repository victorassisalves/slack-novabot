const admin = require('firebase-admin');
admin.initializeApp({
  credential: admin.credential.applicationDefault()
});
export const FieldValue = admin.firestore.FieldValue;



export const db = admin.firestore();