#!/usr/bin/env ruby -w

module Func
  def ask user, param
    user.print param
  end
  
  def tell user, param
    user.puts param
  end
  
  def input_from user
    return user.gets.chomp
  end
  
  def note param
    puts param
  end
  
  def first_key_of param
    return param.keys.first
  end
  
  def count_numbers_from param
    
  end
  
  def last_key_of param
    return param.keys.last
  end
  
  def select_from hash, param
    return hash.select{|key, value| "#{param} ".include? " #{value} "}
  end
  
  def commit_at client, param
    system "curl -bg -sL #{param} | ruby"
  end
  
  def at_this_time
    return Time.now
  end
        
  def quit user
    user.close
  end
end