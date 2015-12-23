require 'spec_helper'












describe "Creating todo lists" do

	def create_todo_lists(options={})
		options[:title] ||="My Todo List"
		options[:description] ||="This is my todo list."

		visit "/todo_lists"
		click_link "New Todo list"

		expect(page).to have_content("New Todo list") 
		fill_in "Title", with: options[:title]
		fill_in "Description", with: options[:description]
		click_button "Create Todo list"
	end


#expect the page to have content: "My Todo List"
	it "redirects to the todo list index page on success" do

		create_todo_lists
		expect(page).to have_content("My Todo List")

	end



#title precense test
	it "displays an error when the todo list has no title" do

		expect(TodoList.count).to  eq(0)

		create_todo_lists title: ""

		expect(page).to have_content("error")
		expect(TodoList.count).to  eq(0)

		visit "/todo_lists"
		expect(page).to_not have_content("This is what I am doing today") 
	end	


#title length test
	it "displays an error when the todo list has a title with less than 
		3 characters" do

		expect(TodoList.count).to  eq(0)

		create_todo_lists title: "Hi"

		expect(page).to have_content("error")
		expect(TodoList.count).to  eq(0)

		visit "/todo_lists"
		expect(page).to_not have_content("This is what I am doing today") 
	end	

#description-test: presence test
it "displays an error when the todo list has NO description" do

		expect(TodoList.count).to  eq(0)

		create_todo_lists title: "Grocery List",  description: ""


		expect(page).to have_content("error")
		expect(TodoList.count).to  eq(0)

		visit "/todo_lists"
		expect(page).to_not have_content("Grocery List") 
	end	


#description-test: length test (5)
it "displays an error when the todo list has NO description" do

		expect(TodoList.count).to  eq(0)

		create_todo_lists title: "Grocery List", description: "Food"

		expect(page).to have_content("error")
		expect(TodoList.count).to  eq(0)

		visit "/todo_lists"
		expect(page).to_not have_content("Grocery List") 
	end	


end

