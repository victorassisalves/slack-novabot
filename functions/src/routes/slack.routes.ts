import * as express from "express";
import * as cors from "cors";
import { saveQuote } from "../controller/slack.controller";


const slack = express();

slack.use(cors({ origin: true }));

slack.post("/novaquotes", async (req, res) => {

    console.log(req.body)
    console.log(`TCL: req.body`, req.body.text);
    console.log(`TCL: req.body`, req.body.user_name);

    const result = await saveQuote(req); 
    res.send(result)
    
});

module.exports = slack;