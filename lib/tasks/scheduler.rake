desc "This task is called by the Heroku scheduler add-on to alert users of coming events"
task :send_reminders => :environment do
    Event.remind_users
end