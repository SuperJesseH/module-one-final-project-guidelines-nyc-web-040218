require_relative '../config/environment'

ActiveRecord::Base.logger = nil
puts
puts
puts "Welcome to the Eat Your Feelings Database\n".light_green
run_program = true


def help
  <<-TEXT

  Commands:
  All restaurants - Displays a list of all restaurants in database
  All reviewers - Displays a list of all reviewers in database
  Show all <EMOTION> reviews - Displays all reviews matching given emotion type
  Show all <EMOTION> restaurants - Show all restaurants matching given emotion
  Show all <EMOTION> reviewers - Show all reviewers expressing given emotion
  <RESTAURANT NAME> emotions - See emotional analysis for given restaurant
  <REVIEWER NAME> emotions - See emotional analysis for given reviewer
  <RESTAURANT NAME> reviews - See reviews for given restaurant
  <REVIEWER NAME> reviews - See reviews from given reviewers
  Enter database - Allows regular commands on User(reviewer), Review, and Restaurant classes.
  Help - Display this menu
  Exit - Quit program

  Options:
  Emotions = "angry", "sarcasm", "happy", "excited", "sad", "bored", "fear"

  Examples:
  "All restaurants"
  "show all sad restaurants"
  "China Chalet emotions"
  "Mike Champion reviews"
  TEXT
end
def error_msg
  puts
  puts "Command not recognized!".red
  puts "Names are case sensitive".red
  puts "Type \"Help\" for more info".red
end

puts help.light_green

while run_program == true
  puts "**************".light_green
  puts "\nEnter Command:".light_green
  response = gets.chomp
  down_response = response.downcase
  if down_response == "exit"
    puts
    run_program = false
    bye = ["farewell", "adieu", "au revoir", "ciao", "adios", "bye", "bye-bye", "so long", "see you later", "see you", "sayonara", "bon voyage", "cheers"]
    puts bye.sample.green
  elsif down_response == "help"
    puts
    puts help.light_green
  elsif down_response == "all restaurants"
    puts
    puts Restaurant.primary_emotion
  elsif down_response == "all reviewers"
    puts
    puts User.primary_emotion
  elsif down_response =="enter database"
    puts
    puts "WARNING FOR ADVANCED USERS ONLY!!!".red
    puts "type 'exit' to return to regular interface"
    puts "continue (type y/n)"
    r2 = gets.chomp
    if r2 == "y"
      binding.pry
    end
  elsif down_response[0..3] == "show" && down_response[-7..-1] == "reviews"
    if down_response.include? "sad"
      puts
      Review.given_emotion("sad")
    elsif down_response.include? "angry"
      puts
      Review.given_emotion("angry")
    elsif down_response.include? "sarcasm"
      puts
      Review.given_emotion("sarcasm")
    elsif down_response.include? "happy"
      puts
      Review.given_emotion("happy")
    elsif down_response.include? "excited"
      puts
      Review.given_emotion("excited")
    elsif down_response.include? "bored"
      puts
      Review.given_emotion("bored")
    elsif down_response.include? "fear"
      puts
      Review.given_emotion("fear")
    else
      error_msg
    end
  elsif down_response[0..3] == "show" && down_response[-11..-1] == "restaurants"
    if down_response.include? "sad"
      puts
      Restaurant.sorted_by_given_emotion("sad")
    elsif down_response.include? "angry"
      puts
      Restaurant.sorted_by_given_emotion("angry")
    elsif down_response.include? "sarcasm"
      puts
      Restaurant.sorted_by_given_emotion("sarcasm")
    elsif down_response.include? "happy"
      puts
      Restaurant.sorted_by_given_emotion("happy")
    elsif down_response.include? "excited"
      puts
      Restaurant.sorted_by_given_emotion("excited")
    elsif down_response.include? "bored"
      puts
      Restaurant.sorted_by_given_emotion("bored")
    elsif down_response.include? "fear"
      puts
      Restaurant.sorted_by_given_emotion("fear")
    else
      error_msg
    end
  elsif down_response[0..3] == "show" && down_response[-9..-1] == "reviewers"
    if down_response.include? "sad"
      puts
      User.sorted_by_given_emotion("sad")
    elsif down_response.include? "angry"
      puts
      User.sorted_by_given_emotion("angry")
    elsif down_response.include? "sarcasm"
      puts
      User.sorted_by_given_emotion("sarcasm")
    elsif down_response.include? "happy"
      puts
      User.sorted_by_given_emotion("happy")
    elsif down_response.include? "excited"
      puts
      User.sorted_by_given_emotion("excited")
    elsif down_response.include? "bored"
      puts
      User.sorted_by_given_emotion("bored")
    elsif down_response.include? "fear"
      puts
      User.sorted_by_given_emotion("fear")
    else
      error_msg
    end
  elsif down_response[-8..-1] == "emotions"
    mod_respose = response.gsub(" emotions","")
    if User.all_names.include? mod_respose
      User.find_by(name: mod_respose).emotions
    elsif Restaurant.all_names.include? mod_respose
      Restaurant.find_by(name: mod_respose).emotions
    else
      error_msg
    end
  elsif down_response[-7..-1] == "reviews" && down_response[0..3] != "show"
    mod_respose = response.gsub(" reviews","")
    if User.all_names.include? mod_respose
      User.find_by(name: mod_respose).pretty_reviews
    elsif Restaurant.all_names.include? mod_respose
      Restaurant.find_by(name: mod_respose).pretty_reviews
    else
      error_msg
    end
  else
    error_msg
  end
end
