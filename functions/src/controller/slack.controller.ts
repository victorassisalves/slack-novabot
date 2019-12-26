import { db } from "../database/config";
export const saveQuote = async (req: any) => {
    try {
        const user = `${req.body.user_name}`
        let docRef = db.collection('users').doc(user);
    
        const ref = await docRef.add({
            quote: `${req.body.text}`,
            author: `${req.body.user_name}`
        });


        console.log(`TCL: ref`, ref);

        return 'Quote posted'
    } catch (error) {
        console.error(new Error(`TCL: error, ${JSON.stringify(error)}`));
        return `error posting quote`
    }
}
