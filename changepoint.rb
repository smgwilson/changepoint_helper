class ChangepointHelper

  def initialize(hours = 40)
    @hours = hours
  end

  def start_program
    puts "Welcome to Changepoint Helper!"
    puts "Changepoint sucks, but this program will help it suck a little less :-D"
    puts "_____________________________________________________________________"
    @hours = get_hours
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
	end

	def calc_project_hours (total_hours)
		puts "What percentage of time did you spend on this project?"
		print "> "
		percentage = $stdin.gets.chomp.to_f
		project_hours = (percentage * total_hours) / 100
		puts "Hours spent on this project were #{project_hours}"
	end

	def keep_going
		puts "Do another calculation? (y/n)"
		print "> "
		do_another = $stdin.gets.chomp.downcase
		if do_another == "y"
			run_program
		elsif do_another = "n"
			exit(0)
		else
			"You didn't enter a valid selection."
			keep_going
		end
	end

	def run_program

		puts "What do you want to calculate?"
		puts " "
		puts "1. Percentages"
		puts "2. Project Hours"
		print "> "

		choice = $stdin.gets.chomp

		if choice == "1"
			calc_percentage (hours)
		elsif choice == "2"
			calc_project_hours (hours)
		else
			puts "You didn't enter a valid selection."
		end

		keep_going

	end
end

cp = ChangepointHelper.new
cp.run_program
