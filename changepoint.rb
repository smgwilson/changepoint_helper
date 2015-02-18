class ChangepointHelper

  def initialize(hours = 40)
    @hours = hours
    @all_percentages = Array.new
    @all_hours = Array.new
  end

  # manage program flow
  def run_program(do_next)
    case do_next
      when "start"
        start_program
      when "continue"
        calculation_loop
      when "end"
        end_program
    end
  end

  # introduce user to program options
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
    select_calculation_type (@choice)
  end

  # set initial user input on calculation to perform
  def select_calculation_type (option)
    if option == "1"
      calc_percentage (@hours)
    elsif option == "2"
      calc_project_hours (@hours)
    else
      puts "You didn't enter a valid selection."
    end

    calculation_loop
  end

  # get total hours worked this week from user input
	def get_hours
		puts "How many total hours did you work this week?"
		print "> "
		total_hours = $stdin.gets.chomp.to_f
	end

	def calc_percentage (total_hours)
		puts "How many hours did you spend on this project?"
		print "> "
		project_hours = $stdin.gets.chomp.to_f
		percentage = (project_hours * 100) / total_hours
		puts "Your percentage of time on this project was #{percentage}%"
    @all_percentages.push (percentage)
    @all_hours.push (project_hours)
    sum_p = get_percentage_progress(@all_percentages)
    sum_h = get_hours_progress(@all_hours)
    hours_left = remaining_hours (sum_h)
    puts "You have #{hours_left} hours remaining."
    if sum_p == 100
      puts "You're at 100%!"
    elsif sum_p > 100
      puts "You've exceeded 100%"
    else
      puts "You're up to #{sum_p}%"
    end
	end

	def calc_project_hours (total_hours)
		puts "What percentage of time did you spend on this project?"
		print "> "
		percentage = $stdin.gets.chomp.to_f
		project_hours = (percentage * total_hours) / 100
		puts "Hours spent on this project were #{project_hours}"
    @all_hours << project_hours
    @all_percentages << percentage
    sum_p = get_percentage_progress(@all_percentages)
    sum_h = get_hours_progress(@all_hours)
    hours_left = remaining_hours (sum_h)
    if sum_h == @hours
      puts "You're at #{hours} hours."
    elsif sum_h > @hours
      puts "You've exceeded your reported hours."
    else
      puts "You're up to #{sum_h} hours."
    end
  end

  # can I use duck typing here?
  def get_hours_progress (tot_hours)
    tot_hours.inject {|sum,x| sum + x}
  end

  # can I used duck typing here?
  def get_percentage_progress(tot_percentages)
    tot_percentages.inject{|sum,x| sum + x }
  end

  # total hours worked - total hours added
  def remaining_hours (tot_hours)
    @hours - tot_hours
  end

  # subtract all percentages from 100%
  def remaining_percentage (tot_percentage)
    100 - tot_percentage
  end

	def calculation_loop
		puts "Do another calculation? (y/n)"
		print "> "
		do_another = $stdin.gets.chomp.downcase
		if do_another == "y"
			select_calculation_type (@choice)
		elsif do_another == "n"
      end_program
		else
			"You didn't enter a valid selection."
			calculation_loop
		end
  end

  def end_program
    puts "All done--Goodbye!"
    exit(0)
  end

end

cp = ChangepointHelper.new
cp.run_program("start")

