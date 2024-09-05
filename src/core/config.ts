import { ConfigI } from "../types/local_types";
import process from 'process'

let CONFIG= {} as ConfigI;


export function setConfigOnStart() {
  
  CONFIG.host = process.env.host || '';
  CONFIG.port = Number(process.env.port) || 6060;
  CONFIG.txNewOpenAiApi = process.env.TX_NEW_OPEN_AI_API_KEY || 'MY_OPENAPI_KEY';
}

export function getConfig() {
	return CONFIG;
}
