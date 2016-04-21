#!/usr/bin/env ruby -w

module Modul
  BOTNICK = "Bot"
  HOTHEAD = 5
  HEADERS = ["Domain", "Host", "Port", "IP", "Name", "Last login"]
  COMMAND = {
    quit:"exit", 
    gif: "--",
    clients:"clients",
    giftable:"gifs table",
    bot:"-",
    owlsmall:"small owl",
    owlsharp:"sharp owl",
    pacmansmall:"small pacman",
    pacmanbig:"big pacman",
    ponysharp:"sharp pony",
    ponysmall:"small pony",
    nyancat:"nyan cat",
    mail:"=mail",
    kitten:"kitten"
  }
  #refs from github.com/JoshCheek/animated-gif-in-the-terminal
  GIFS = {
    owlsmall:"http://bit.ly/1DRCK7q",
    owlsharp:"http://bit.ly/1EEKZ7v",
    pacmansmall:"http://bit.ly/1JdRkxh",
    pacmanbig:"http://bit.ly/1HhjojP",
    ponysharp:"http://bit.ly/1H3EUmQ",
    ponysmall:"http://bit.ly/1QJs83R",
    nyancat:"http://bit.ly/1KK1GD9",
    kitten:"http://bit.ly/1A0iNjU"
  }
  QUESTION = {
    live:"live",
    place:"place",
    stay:"stay",
    full:"full name",
    name:"name",
    hello:"hello",
    how:"how",
    hey:"hey",
    ask0:"can i",
    ask1:"ask,",
    ask2:"ask.",
    ask3:"ask",
    callyou:"call you",
    call:"call",
    hi:"hi",
    sorry:"sorry",
    any:"anybody",
    amsorry:"sorry",
    age:"age",
    dota:"dota",
    annoy:"annoy",
    old:"old",
    owner:"owner",
    game:"games",
    play:"play",
    love:"love",
    okay:"okay",
    like:"like",
    music:"music",
    sick:"sick",
    speak:"speak",
    friend:"friend",
    about1:"about you",
    about2:"yourself",
    tellpeople:"tell people"
  }
  ANSWER = {
    hi:"Hi.. Nice to chat with you",
    age:"Age is just a plain number for me. I could live forever",
    how:"I'm fine, thanks",
    ask0:"yes...",
    ask1:"Okey...",
    ask2:"I'm listening...",
    ask3:"No, it's okay. please ask it to me",
    sorry:"No worries. I'm happy to be helpful",
    callyou:"Well, I will barely notice if you call me with that name",
    amsorry:"Alright then, I'll try to forgive you. I'm living alone here anyway",
    live:"I live in a digital world inside your computer",
    old:"I forgot to count. I was born ages ago, but I still feel young",
    place:"I don't actually have a place, my owner pick the place for me",
    stay:"I didn't realy think about it. I just wanna be alive",
    annoy:"I'm alright. people always ask me a lot of questions",
    amannoy:"You're starting to annoy me. I wont chat with you until you say your sorry, hmph",
    owner:"I'm confused!! I don't know which one is my real owner. Everyone looks the same in here",
    any:"Yes, I'm right here, you can ask me anything",
    game:"I know a lot of games. But sadly, I can't play it. I can only see 0 and 1",
    name:"My name is Bot",
    full:"My full name is roBot. A digital user in this chat room",
    hey:"Hey there!!",
    like:"I don't know what I really like to do. Everything is possible to me",
    play:"I like playing with algorithms. I hope you like it too",
    hello:"Hello there too, thank you for joining my chat room ^_^",
    music:"I am greatful to live in your computer. I like all your musics. It's awesome ^_^",
    call:"usually people call me Bot, bu I don't really used to it though",
    dota:"I don't really play that kind of game, but it is really fun to watch XD",
    sick:"Thankfully I'm okay now. It's really been a hard day for me",
    okay:"yes, I'm alrighht, thanks for asking",
    love:"I don't think I should answer that question... yet",
    speak:"Well... I was born to speak Ruby, but I'm also open to more languages",
    about1:"Hmmm... I'm single LOL",
    about2:"Okayy... First thing to note, I'm not a likeable friend like you always have, I have no intention to think about anybody",
    friend:"Yes, but they don't recognize me that much",
    tellpeople:"I'm sorry. I can't do that right now. I'm still in my training"
  }
end