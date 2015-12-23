#filename: edit_spec.rb
#language: ruby
#author: Nicolas Roldos
#part of 'http://teamtreehouse.com' tutorial-track on
# 'Development With Ruby On Rails'



require 'spec_helper'




describe "Editing todo lists" do

	let!(:todo_list) {TodoList.create(title: "Calls",
					description: "Call Geico, DMV and others.")}

	def update_todo_list(options={})
		options[:title] ||= "My todo list"
		options[:description] ||= "These are the items in my todo list"
		todo_list = options[:todo_list]
		visit "/todo_lists"

		#target: <tr id="<%= dom_id(todo_list) %>">
		# element in the 'DOM' of 'index.html.erb'	
		within "#todo_list_#{todo_list.id}" do
			click_link "Edit"
		end

		fill_in "Title", with: options[:title]
		fill_in "Description", with: options[:description]

		click_button "Update Todo list"	
	end

	#--Conditions and scenarios to test for:
	it "updates a todo list successfully with correct information" do
		update_todo_list todo_list: todo_list,
										 title: "New title",
										 description: "New description"
		#--above: all parameters are filled in using 'update_todo_list' method
		#--below: reloads the 'todo_list' from sql database
		todo_list.reload

		#--All should run smooothly and inputs should appear on the
		#reloaded todo_list webpage
		expect(page).to have_content("Todo list was successfully updated")
		expect(todo_list.title).to eq("New title")
		expect(todo_list.description).to eq("New description")
	end 


	it "displays an error with no title" do
    update_todo_list todo_list: todo_list, title: ""
    #--This time the 'update_todo_list' method is called, however 
    #the 'title' parameter is left intentionally blank
    title = todo_list.title
    todo_list.reload
    #--webpage is realoaded and an explanatory error message 
    #is displayed
    expect(todo_list.title).to eq(title)
    expect(page).to have_content("error")
  end


  it "display error for too short a title" do
  	#--'update_todo_list' method is called, however the 'title'
  	#parameter has too few characters and is 'invalidated'
    update_todo_list todo_list: todo_list, title: "hi"
    expect(page).to have_content("error")
  end


  it "display error for NO description" do
  	#--'update_todo_list' method is called, however the 'description'
  	#parameter is left blank
    update_todo_list todo_list: todo_list, description: ""
    expect(page).to have_content("error")
  end


  it "display error for too short a description" do
  	#--'update_todo_list' method is called, however the 'description'
  	#parameter has too few characters and is 'invalidated'
    update_todo_list todo_list: todo_list, description: "go"
    expect(page).to have_content("error")
  end
end





