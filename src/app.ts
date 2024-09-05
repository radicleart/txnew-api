import { setConfigOnStart, getConfig } from './core/config';
import bodyParser from "body-parser";
import express from "express";
import morgan from "morgan";
import cors from "cors";
import { configRoutes } from './server/routes/config/configRoutes'
import { initOpenAI, openaiRoutes } from './server/routes/openai/openaiRoutes'
import { WebSocketServer } from 'ws'
import dotenv from 'dotenv';

if (process.env.NODE_ENV === 'development') {
  dotenv.config();
}

const app = express();
app.use(bodyParser.json({ limit: '10mb' }));
app.use(bodyParser.urlencoded({ extended: true, limit: '10mb' }));
app.use(express.json());

app.use(morgan("tiny"));
app.use(express.static("public"));
app.use(cors()); 
setConfigOnStart();

app.use((req, res, next) => {
  console.log('app.use: ok ' + req.method)
  next()
})

app.use('/config', configRoutes);
app.use('/openai', openaiRoutes);

console.log(`\n\nExpress is listening at http://localhost:${getConfig().port}`);
console.log('Startup Key: ', `${getConfig().txNewOpenAiApi.substring(0, 3)}..`);

const server = app.listen(getConfig().port, () => {
  initOpenAI()  ;
  return;
});
const wss = new WebSocketServer({ server })

wss.on('connection', function connection(ws:any) {
  ws.on('message', function incoming(message:any) {
    ws.send('Got your new rates : ' + message)
  })
})

