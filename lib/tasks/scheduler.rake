desc "This task is called by the Heroku scheduler add-on to alert users of coming events"
task :send_reminders => :production do
    Alarm.proba
end