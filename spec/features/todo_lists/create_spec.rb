#filename: create_spec.rb
#date: 12.22.2015
#author: nicolas roldos
#part of 'http://teamtreehouse.com' tutorial-track 
# "Developing Software Applications with Ruby-On-Rails for the Web"


require 'spec_helper'





describe "Creating todo-lists" do
	#--integrative testing and validation of todo-list functions and interfaces
	# for this small 'todo-list app'

	def create_todo_list(options={})
		options[:title] ||= "Nico's todo-list"
		options[:description] ||= "This is what Nico is doing today"
		#--Above code checks to see if page has the correct 
		# 'default' title: "New Todo List" in the header of the web-app
		visit "/todo_lists"
		click_link "New Todo list"
		expect(page).to have_content("New Todo List")
		#--'title' and 'description' as variables allow for a diversity values 
		# to be tested.
		# Test can simulate user-actions on webpage like 'click_button' or 
		# 'click_link'
		fill_in "Title", with: options[:title]
		fill_in "Description", with: options[:description]
		click_button "Create Todo list"
		#--This method is repeatedly applied to test different scenarios
		# of execution, 'validation' or 'completion' of 'todo-list' parameters
	end


	it "redirects to the todo-list index page on success" do
		create_todo_list
		expect(page).to have_content("Nico's todo-list")
		#--this test scenario uses the default values defined in the 
		# 'create_todo_list' method
		#--Checks to see that default value for title is stored and displayed
		# on webpage
	end


	it "shows error when todo-list is missing a title" do
		#Array is expected to be 'cleared' before creating a new list
		expect(TodoList.count).to eq(0)
		#--this test case shows what happens when there is a 'null' value for the 
		# 'title' parameter using the 'create_todo_list' method
		create_todo_list title: ""
		#--'error' handling:
		# After clicking the button "Create Todo list" with a 'null' 'title' 
		# parameter an explanatory 'error message' should present itself
		#--This test case also checks to make sure there are no 'defaults'
		# leftover from the 'create_todo_list' method
		expect(page).to have_content("error")
		expect(TodoList.count).to eq(0)
		#--user is then redirected back to the 'todo-lists' prompt page
		#All fields are cleared including any 'defaults'
		visit "/todo_lists"
		expect(page).to_not have_content("This is what Nico is doing today")
	end


	it "invalidates 'title' less than 3 characters long" do
		expect(TodoList.count).to eq(0)
		create_todo_list title: "My"
		#--when the 'title' parameter is too short it is 'invalidated'
		expect(page).to have_content("error")
		expect(TodoList.count).to eq(0)
		#--this test demostrates a similar scenario to a 'null' 'title'
		# No 'default' items are displayed and an explanatory error message 
		# should be presented to the user here
		visit "/todo_lists"
		expect(page).to_not have_content("This is what Nico is doing today")
		#--user is redirected back to 'todo-lists' prompt, all fields are cleared
	end


	it "shows error when a todo-list 'description' is left empty" do
			expect(TodoList.count).to eq(0)
			create_todo_list title: "Nico's todo-list", description: ""
			#--'null' value for the 'decription' parameter is handled
			expect(page).to have_content("error")
			expect(TodoList.count).to eq(0)
			#--explanatory error provided and list is nulled
			visit "/todo_lists"
			expect(page).to_not have_content("This is what Nico is doing today")
			#--user is redirected back to 'todo-lists' prompt and all fields are
			#cleared including any defaults or a 'title' parameter value
	end


	it "invalidates 'description' less than 5 characters long" do
			expect(TodoList.count).to eq(0)
			create_todo_list title: "Nico's todo-list", description: "go"
			#--when the 'description' parameter is too short it is 'invalidated'
			expect(page).to have_content("error")
			expect(TodoList.count).to eq(0)
			visit "/todo_lists"
			expect(page).to_not have_content("This is what Nico is doing today")
			#--user is redirected back to 'todo-lists' prompt, all fields are cleared
	end
end