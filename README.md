# RoomDraw

This the Repository for the entirety of the CS133 Project created by
Eric Campbell, Daniel Metz, and Kevin Wynn. The top-level directory
contains the LaTeX Files for the milestones, all of the code for
the application is in the `RoomDraw` directory.

## The Business Logic

There are about 700 files involved in this Rails app, many are stubs,
and many are short files that Rails needs to work its magic. Here's
where to start.

Most of the important business code is contained in the `RoomDraw/app`
directory.  This is divided into 
```
app/
  |  assets/       # Front-End design stuff (stylesheets, javascripts) -- Nothing important here.
  |  controllers/  # Controls the REST Interface for each namespace.
  |  helpers/      # These provide methods to the namespace, often used to provide methods to the views. 
  |  models/       # The Object-Data Models. There is one for each Relation in the DB. Associations and Validations are specified here
  |  services/     # the *CreationServices all live here. They are used to ensure invariants on Insert/Delete/Update
  |--views/        # Ruby-Html html stubs that are served

```
### Namespaces
Rails has the notion of namespaces that tie together Controllers, Helpers and Views.
For some Controller, for example the `SearchController`, there are actions that correllate to
view partials that are defined in the namespaced subdirectory, for example 
`views/search`. The views have access to the methods defined in the namespaced
helper file, in this example called `SearchHelper`.

## Database Setup

The database configuration files can be found in the `db` directory.  The database
migrations can be found in `db/migrate`, and the dump file that
represents the current schema can be found in `db/schema.rb`.

## Rake Task for Automated Draw
The code for the rake task can be found in `lib/tasks/draw.rake`. It
can be run locally via the command
```shell
rake draw:auto[2015]
```
and on heroku by appending `heroku run` to the beginning of the previous
command.

## Routes

The `config/routes.rb` file specifies the controller actions to which 
REST API calls are directed.  For the full oupput of the routes,
run  
```
rake routes
```
