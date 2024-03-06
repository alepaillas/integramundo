""" You can create a server action for this from user interface.

Steps:

1. Activate developer mode

2. Navigate to Server Actions menu under Settings -> Technical -> Actions -> Server Actions

3. Create a new server action.

4. Give name as Reset To Draft, select model as Journal Entry(ie, account.move), Action To Do as Execute Python Code, then in python code add below code

 """
for record in records:

    record.button_draft()

""" 
5. Click Create Contextual Action

6. Refresh the screen, from invoice tree view, select all records you need and from actions button click the Reset To Draft.


For More: https://www.youtube.com/watch?v=TXBjlnfbZg8


 """