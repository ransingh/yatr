Robot Simulation
=====  

1. Ensure that following dependencies are met
   - ruby version is  *ruby-2.2.0*
   - rbenv is installed (as the app uses .ruby-version)
   - run `bundle --path=.bundle --binstubs` to install all gems

2. To run specs 'bundle exec rspec'

3. To run the robot simulation, just type  
   `./scripts/robot_simulator ./scripts/command.txt`

   - all the commands are place in the `command.txt` file in scripts folder
    * commands are read from this file & fed into the simulated robot.  
    * it includes valid commands ( MOVE, PLACE, LEFT, RIGHT)
    * few invalid commands (just to check error handling)

4. All error, exception (when robot can fall due to a command), debug information is logged into the log file `log/robot_[environment]. log`.
