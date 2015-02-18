class ChangepointHelper

  def initialize(hours = 40)
    @hours = hours
    @all_percentages = Array.new
    @all_hours = Array.new
  end

  def run_program(do_next)
    case do_next
      when "start"
        start_program
      when "continue"
        keep_going
      when "end"
        end_program
    end
  end

  # get user selection on calculation to perform
  def start_program
    puts "Welcome to Changepoint Helper!"
    puts "Changepoint sucks, but this program will help it suck a little less :-D"
    puts "_____________________________________________________________________"
    @hours = get_hours

    puts "What do you want to calculate?"
    puts " "
    puts "1. Percentages"
    puts "2. Project Hours"
    print "> "

    @choice = $stdin.gets.chomp
    select_calculation(@choice)

  end

  def select_calculation(option)
    if option == "1"
      calc_percentage (@hours)
    elsif option == "2"
      calc_project_hours (@hours)
    else
      puts "You didn't enter a valid selection."
    end

    keep_going

  end

	def get_hours
		puts "How many total hours did you work this week?"
		print "> "
		total_hours = $stdin.gets.chomp.to_f
	end

	def calc_percentage (total_hours)
		puts "How many hours did you spend on this project?"
		print "> "
		project_hours = $stdin.gets.chomp.to_f
		# puts "The project hours are #{project_hours}"
		# puts "The total hours worked are #{total_hours}"
		percentage = (project_hours * 100) / total_hours
		puts "Your percentage of time on this project was #{percentage}%"
    @all_percentages.push (percentage)
    sum = @all_percentages.inject{|sum,x| sum + x }
    if sum == 100
      puts "You're at 100%!"
    elsif sum > 100
      puts "You've exceeded 100%"
    else
      puts "You're up to #{sum}%"
    end
	end

	def calc_project_hours (total_hours)
		puts "What percentage of time did you spend on this project?"
		print "> "
		percentage = $stdin.gets.chomp.to_f
		project_hours = (percentage * total_hours) / 100
		puts "Hours spent on this project were #{project_hours}"
    @all_hours << project_hours
    sum = @all_hours.inject{|sum,x| sum + x}
    if sum == @hours
      puts "You're at #{hours} hours."
    elsif sum > @hours
      puts "You've exceeded your reported hours."
    else
      puts "You're up to #{sum}%"
    end
	end

	def keep_going
		puts "Do another calculation? (y/n)"
		print "> "
		do_another = $stdin.gets.chomp.downcase
		if do_another == "y"
			select_calculation(@choice)
		elsif do_another == "n"
			exit(0)
		else
			"You didn't enter a valid selection."
			keep_going
		end
  end

end

cp = ChangepointHelper.new
cp.run_program("start")

