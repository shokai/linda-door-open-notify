Linda Door Notify
=================
notify door-open to skype and say-command with RocketIO::Linda

- https://github.com/shokai/linda-door-open-notify
- watch Tuples ["door", "open", "success"]
- write Tuples
  - ["say", "#{name}でドアが開きました"]
  - ["skype", "send", "#{name}でドアが開きました"]
  - ["twitter", "tweet", "#{name}でドアが開きました"]

Dependencies
------------
- Ruby 1.8.7 ~ 2.0.0
- [linda-delta-door-open](https://github.com/masuilab/linda-delta-door-open)
- [linda-mac-say](https://github.com/shokai/linda-mac-say)
- [linda-skype](https://github.com/shokai/linda-skype)
- [linda-twitter](https://github.com/shokai/linda-twitter)
- [LindaBase](https://github.com/shokai/linda-base)


Install Dependencies
--------------------

    % gem install bundler foreman
    % bundle install


Run
---

set ENV var "LINDA_BASE", "LINDA_SPACES" "LIGHT_THRESHOLD"

    % export LINDA_BASE=http://linda.example.com
    % export LINDA_SPACES="shokai_room,my_room,my_room2"  ## separate with comma
    % export LIGHT_THRESHOLD=30
    % bundle exec ruby linda-door-open-notify.rb

or

    % LINDA_BASE=http://linda.example.com LINDA_SPACES="shokai_room,my_room,my_room2" LIGHT_THRESHOLD=30 bundle exec ruby linda-door-open-notify.rb


Install as Service
------------------

for launchd (Mac OSX)

    % sudo foreman export launchd /Library/LaunchDaemons/ --app linda-door-open-notify -u `whoami`
    % sudo launchctl load -w /Library/LaunchDaemons/linda-door-open-notify-main-1.plist

for upstart (Ubuntu)

    % sudo foreman export upstart /etc/init/ --app linda-door-open-notify -d `pwd` -u `whoami`
    % sudo service linda-door-open-notify start
