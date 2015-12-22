require 'spec_helper'

describe "Creating todo lists" do

#root redirect test
	it "redirects to the todo list index page on success" do
		
		visit "/todo_lists"
		click_link "New Todo list"
		expect(page).to have_content("New Todo List") 

		fill_in "Title", with: "My todo list"
		fill_in "Description", with: "This is what I am doing today"

		click_button "Create Todo list"
		expect(page).to have_content("My todo list")
	end

#title precense test
	it "displays an error when the todo list has no title" do

		expect(TodoList.count).to  eq(0)

		visit "/todo_lists"
		click_link "New Todo list"
		expect(page).to have_content("New Todo List") 

		fill_in "Title", with: ""
		fill_in "Description", with: "This is what I am doing today"

		click_button "Create Todo list"

		expect(page).to have_content("error")
		expect(TodoList.count).to  eq(0)

		visit "/todo_lists"
		expect(page).to_not have_content("This is what I am doing today") 
	end	

#title length test
	it "displays an error when the todo list has a title with less than 
		3 characters" do

		expect(TodoList.count).to  eq(0)

		visit "/todo_lists"
		click_link "New Todo list"
		expect(page).to have_content("New Todo List") 


		fill_in "Title", with: "Hi"
		fill_in "Description", with: "This is what I am doing today"


		click_button "Create Todo list"

		expect(page).to have_content("error")
		expect(TodoList.count).to  eq(0)

		visit "/todo_lists"
		expect(page).to_not have_content("This is what I am doing today") 
	end	

#description-test: presence test
it "displays an error when the todo list has NO description" do

		expect(TodoList.count).to  eq(0)

		visit "/todo_lists"
		click_link "New Todo list"
		expect(page).to have_content("New Todo List") 


		fill_in "Title", with: "Grocery List"
		fill_in "Description", with: ""


		click_button "Create Todo list"

		expect(page).to have_content("error")
		expect(TodoList.count).to  eq(0)

		visit "/todo_lists"
		expect(page).to_not have_content("Grocery List") 
	end	

#description-test: length test (5)
it "displays an error when the todo list has NO description" do

		expect(TodoList.count).to  eq(0)

		visit "/todo_lists"
		click_link "New Todo list"
		expect(page).to have_content("New Todo List") 


		fill_in "Title", with: "Grocery List"
		fill_in "Description", with: "Food"


		click_button "Create Todo list"

		expect(page).to have_content("error")
		expect(TodoList.count).to  eq(0)

		visit "/todo_lists"
		expect(page).to_not have_content("Grocery List") 
	end	


end

