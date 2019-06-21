# TodoNotes

To start application:

  * Get dependencies wiht `mix deps.get` 
  * Start Phoenix endpoint with `mix phx.server`

# API
 * GET localhost:4000/api - get tasks list
 
    answer: {
                "tasks": [
                    {
                        "id": 2,
                        "status": "to do",
                        "task": "do 2"
                    },
                    {
                        "id": "1",
                        "status": "done",
                        "task": "do 1"
                    }
                ]
            }
            
 * POST localhost:4000/api - add new task
 
    body: {"id" : 2, "task" : "do 2"}
    
    answer: {
                "status": "success"
            }
            
 * PUT localhost:4000/api/:id - update task
      
    body: {"id" : 1, "task" : "do 1", "status" : "done"}
    
    answer: {
                "status": "success"
            }
            
 * DELETE localhost:4000/api/:id - delete task
    
    answer: {
                "status": "success"
            }