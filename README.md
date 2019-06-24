# TodoNotes

To start application:

  * Get dependencies wiht `mix deps.get` 
  * Start Phoenix endpoint with `mix phx.server`

# API
 *  Get tasks list
 
    method: GET

    url: localhost:4000/api

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
            
    error_answer: {
                      "error": "already_exists"
                  }

 *  Add new task

    method: POST

    url: localhost:4000/api
 
    body: {"id" : 2, "task" : "do 2"}
    
    answer: {
                "status": "success"
            }
            
    error_answer: {
                      "error": "already_exists"
                  }

 *  Update task

    method: PUT

    url: localhost:4000/api/:id
      
    body: {"id" : 1, "task" : "do 1", "status" : "done"}
    
    answer: {
                "status": "success"
            }
            
    error_answer: {
                      "error": "not_found"
                  }

 * Delete task
    
   method: DELETE

   url: localhost:4000/api/:id

   answer: {
                "status": "success"
            }

   error_answer: {
                     "error": "not_found"
                 }