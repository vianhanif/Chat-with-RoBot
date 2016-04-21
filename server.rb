#!/usr/bin/env ruby -w
$LOAD_PATH << '.'
require "socket"
require "colorize"
require "modul"
require "net/smtp"
require "func"
require "terminal-table"

class R
  include Modul
  include Func
end

class Server
  def initialize port
    String.disable_colorization = false
    @server = TCPServer.open port
    @_ = R.new
    @port = port
    @clients_rows = Array.new
    @gifs_rows = Array.new
    @connections = @rooms = @clients = @user = Hash.new
    @ip = Socket.ip_address_list[1].ip_address
    @connections = {server:@server, rooms:@rooms, clients:@clients}
    @table = Terminal::Table
    @headers = Modul::HEADERS
    @command = Modul::COMMAND
    @question = Modul::QUESTION
    @answer = Modul::ANSWER
    @gifs = Modul::GIFS
    @hothead = Modul::HOTHEAD
    @bot_nick = Modul::BOTNICK
    @annoyed = 1
    @guilty = false
    @asked = ""
    run_server
  end
  
  def link
    return @connections[:clients]
  end
    
  def note_properties_for nick_name, user
    sock_domain, remote_port, remote_hostname, remote_ip = user.peeraddr
    @user = {domain:sock_domain, port:remote_port, host:remote_hostname, ip:remote_ip}
  end
  
  def notify_others_as user, param
    link.each do |other_name, other_client|
      @_.tell other_client, param unless other_name == user
    end
  end
  
  def notify_quit_from user, param
    @_.note param
    link.each do |other_name, other_client|
      @_.tell other_client, param unless other_name == user
    end
  end
  
  def add_a_new_link_for user, the_client
    link[user] = the_client
  end
  
  def add_a_new_record_for user
    @clients_rows << [@user[:domain], @user[:host], @user[:port], @user[:ip], user, @_.at_this_time]
  end
  
  def annoys_bot_with param
    case param
      when @asked then @annoyed += 1
      else @asked = param; @annoyed -= 1 if @annoyed > 0; @annoyed = 0 if @annoyed <= 0
    end
  end
  
  def run_server
    @_.note "Chat room has opened at #{@ip}, #@port...".green
    loop {
      Thread.start @server.accept do | the_client |
        @_.ask the_client, "*What is your name : ".green
        me = @_.input_from the_client
        note_properties_for me, the_client
        notify_others_as me, "*#{me} has entered the room [#{@_.at_this_time}]".yellow
        @_.note "*#{me} has entered room [#{@_.at_this_time}]".yellow
        add_a_new_link_for me, the_client
        add_a_new_record_for me
        @_.tell the_client, "*Great!! Now say hello to your friends. Happy chatting...^^".green
        @_.tell the_client, "*type '- ' first to start chatting with roBot".green
        listen_messages_from me, the_client
      end
    }.join
  end

  def listen_messages_from me, the_client
    loop{
      this_message = @_.input_from the_client
      case this_message
        when /#{@command[:gif]}/ then opengif_for me, the_client, this_message
        when /#{@command[:bot]}/ then chat_to_bot_with this_message, me, the_client
        when /#{@command[:clients]}/ then show_clients_table_for the_client 
        when /#{@command[:giftable]}/ then show_gifs_table_for the_client
        when /#{@command[:quit]}/ then @_.quit the_client; notify_quit_from me, "*#{me} has exit the room [#{@_.at_this_time}]".red;
        else chat_using this_message, me
      end
    }
  end

  def chat_using the_message, user
    link.each do |other_name, other_client|
      @_.tell other_client, "\n#{user}: #{the_message}".green unless other_name == user
    end
  end
          
  def chat_to_bot_with the_message, me, the_client
    ask = @_.select_from @question, the_message
    if @annoyed < @hothead
      case @answer[@_.first_key_of ask]
        when String then @_.tell the_client, "#{@bot_nick} : #{@answer[@_.first_key_of ask]}".yellow; annoys_bot_with @answer[@_.first_key_of ask]
        else @_.tell the_client, "#{@bot_nick} : I'm sorry, I haven't learn that sentence".yellow
      end
    else ask_for_forgiveness_from me, the_client, the_message 
    end
  end
      
  def ask_for_forgiveness_from me, the_client, the_message
    if the_message.include? "#{@question[:amsorry]}" 
      say_sorry_from the_client 
    else 
      @_.tell the_client, "#{@bot_nick} : #{@answer[:annoy]}".yellow if @guilty == false; @guilty = true
      link.each do |other_name, other_client|
        @_.tell other_client, "*roBot was annoyed by #{me}. roBot wont talk until #{me} apologize".red unless other_name == me
      end
    end
  end
    
  def say_sorry_from the_client
    @guilty = false
    @annoyed = 0
    @_.tell the_client, "#{@bot_nick} : #{@answer[:amsorry]}".yellow
  end
    
  def show_clients_table_for the_client
    table = @table.new headings:@headers, rows:@clients_rows
    @_.tell the_client, table
  end
    
  def show_gifs_table_for the_client
    @gifs.each{|key, value| @gifs_rows << ["#{@command[:gif]}#{@command[key]}", @gifs[key]]}
    table = @table.new headings:["command", "link"], rows:@gifs_rows
    @_.tell the_client, table
  end
  
  def opengif_for user, the_client, the_message
    @_.tell the_client, "*please wait, start downloading gif...".green
    command = @command.select{|key, value| the_message.include? value} 
    url = @gifs[@_.last_key_of command]
    notify_others_as user, "*#{user} start playing #{command.values.last} gif".green
    @_.commit_at the_client, url
  end
  
end

Server.new 3000