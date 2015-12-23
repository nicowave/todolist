#filename: destroy_spec.rb
#language: ruby
#author: Nicolas Roldos
#part of 'http://teamtreeehouse.com' tutorial-track on
# 'Development With Ruby On Rails'



require 'spec_helper'




describe "Deleting todo lists" do

	let!(:todo_list) { TodoList.create(title: "Calls",
				description: "Call Geico, DMV and others.") }


	it "is succesful when clicking destroy link" do
		#deletes the 'todo_list'
		visit "/todo_lists"
		#--using 'DOM id' to select the precise 'todo_list' to delete
		within "#todo_list_#{todo_list.id}" do
			click_link "Destroy"
		end

		#--Checks to make sure that todo_list parameters are deleleted
		expect(page).to_not have_content(todo_list.title)
		expect(TodoList.count).to eq(0)
	end
end