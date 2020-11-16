const TelegramBot = require('node-telegram-bot-api');


const TOKEN = `1354385957:AAHgE3EWSIa9iWIS5R8DWMONhIBp8uQT5L0`;
const bot = new TelegramBot(TOKEN, {polling: true});

module.exports = bot;