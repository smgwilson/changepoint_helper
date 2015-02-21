class ChangepointHelper

  def initialize(hours = 40, sum_of_percentages = 0, sum_of_hours = 0)
    @hours = hours
    @sum_of_percentages = sum_of_percentages
    @sum_of_hours = sum_of_hours
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

  # get user input for calculation to perform
  def select_calculation_type (option)
    if option == "1"
      calc_percentage (@hours)
    elsif option == "2"
      calc_project_hours (@hours)
    else
      puts "You didn't enter a valid selection."
    end

    run_program("continue")
  end

  # get total hours worked this week from user input
	def get_hours
		puts "How many total hours did you work this week?"
		print "> "
		total_hours = $stdin.gets.chomp.to_f
	end

  # translate project hours into percentage of time spent
	def calc_percentage (total_hours)
		puts "How many hours did you spend on this project?"
		print "> "
		project_hours = $stdin.gets.chomp.to_f
		percentage = (project_hours * 100) / total_hours
    puts "Your percentage of time on this project was #{percentage}%"

    sum_totals(percentage,project_hours)

    if @sum_of_percentages == 100
      puts "You're at 100%!"
      puts "Here are your project percentages:"
      print_values(@all_percentages)
      run_program ("end")
    elsif @sum_of_percentages > 100
      puts "You've exceeded 100%"
      restart
    else
      puts "You're up to #{@sum_of_percentages}%"
    end
	end

  # translate percentage of time spent into project hours
	def calc_project_hours (total_hours)
		puts "What percentage of time did you spend on this project?"
		print "> "
		percentage = $stdin.gets.chomp.to_f
		project_hours = (percentage * total_hours) / 100
		puts "Hours spent on this project were #{project_hours}"

    sum_totals(percentage,project_hours)

    if @sum_of_hours == @hours
      puts "You're at #{@sum_of_hours} hours."
      puts "Here are your project hours:"
      print_values(@all_hours)
      run_program ("end")
    elsif @sum_of_hours > @hours
      puts "You've exceeded your reported hours."
      restart
    else
      puts "You're up to #{@sum_of_hours} hours."
    end
  end

  # not DRY
  # def get_hours_progress (tot_hours)
  #   tot_hours.inject {|sum,x| sum + x}
  # end

  # not DRY
  # def get_percentage_progress(tot_percentages)
  #   tot_percentages.inject{|sum,x| sum + x }
  # end

  # replaces "get_hours_progress" and "get_percentage_progress"
  def get_progress(values)
    values.inject{|sum,x| sum + x}
  end

  # total hours worked - total hours added
  def remaining_hours (tot_hours)
    @hours - tot_hours
  end

  # subtract all percentages from 100%
  def remaining_percentage (tot_percentage)
    100 - tot_percentage
  end

  # total values and calculate remainder
  def sum_totals (latest_percentage, latest_hours)
    @all_hours << latest_hours
    @all_percentages << latest_percentage
    @sum_of_percentages = get_progress(@all_percentages)
    @sum_of_hours = get_progress(@all_hours)
    percentage_left = remaining_percentage(@sum_of_percentages)
    hours_left = remaining_hours (@sum_of_hours)
    puts " "
    puts "You have #{percentage_left}% of your time remaining."
    puts "You have #{hours_left} hours of your time remaining."
  end

  def print_values (arr)
    arr.each_with_index {|val, index| puts "#{index} => #{val}" }
  end

	def calculation_loop
		puts "Do another calculation? (y/n)"
		print "> "
		do_another = $stdin.gets.chomp.downcase
		if do_another == "y"
			select_calculation_type (@choice)
		elsif do_another == "n"
      run_program("end")
		else
			"You didn't enter a valid selection."
			run_program("continue")
		end
  end

  def restart
    puts "Do you want to restart? (y/n)"
    print "> "
    do_another = $stdin.gets.chomp.downcase
    if do_another == "y"
      clear_values
      run_program ("start")
    elsif do_another == "n"
      run_program("end")
    else
      "You didn't enter a valid selection."
      restart
    end
  end

  def clear_values
    initialize
  end

  def end_program
    puts "All done--Goodbye!"
    exit(0)
  end

end

cp = ChangepointHelper.new
cp.run_program("start")

