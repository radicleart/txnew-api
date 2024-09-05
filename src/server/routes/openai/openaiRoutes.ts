
import express from "express";
import { getConfig } from "../../../core/config";
import OpenAI from 'openai';

export let openai: OpenAI;

const router = express.Router();

export function initOpenAI() {
  openai = new OpenAI({
    apiKey: getConfig().txNewOpenAiApi, // use an environment variable to store the API key
  });
}

router.post("/chat", async (req, res, next) => {
  const { prompt } = req.body;
  console.log('prompt: ' + prompt)
  if (!prompt) {
    return res.status(400).send({ error: 'Prompt is required' });
  }

  try {
    // Send prompt to OpenAI API
    const response = await openai.chat.completions.create({
      messages: [
        {
        role: "system",
        content:
            "Respond only with a number, including potential decimals, of what the user entered. Handle metric system (example: 1 micro = 0.000001)",
        },
        { role: "user", content: prompt },
      ],
      model: "gpt-3.5-turbo",
      //model: 'gpt-4', // Specify the model you want to use (e.g., 'gpt-3.5-turbo', 'gpt-4')
      max_tokens: 100,
      temperature: 0,
    });

    const chatResponse = response.choices[0].message.content;

    // Send the response back to the client
    return res.send({ response: chatResponse });
  } catch (error) {
    console.error('Error calling OpenAI API:', error);
    return res.status(500).send({ error: 'Something went wrong' });
  }
});

export { router as openaiRoutes }
