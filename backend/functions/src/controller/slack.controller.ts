import { db, FieldValue } from "../database/config";



export const saveQuote = async (req: any) => {
    try {
        const user = `${req.body.user_name}`
        await db.collection('quotes').add({
            text: `${req.body.text}`,
            author: user,
            likes: 0,
            timestamp: FieldValue.serverTimestamp()
          }).then((ref: any) => {
            console.log('Added document with ID: ', ref.id);
          });
        // let docRef = db.collection('users').doc(user);
    
        // const ref = await docRef.add({
        //     quote: `${req.body.text}`,
        //     author: `${req.body.user_name}`
        // });

        return 'Quote posted'
    } catch (error) {
        console.error(new Error(`TCL: error, ${JSON.stringify(error)}`));
        return `error posting quote`
    }
}
