namespace :settings do

    task :set_message => :environment do
        _, message = ARGV
        if !message
            print "Missing parameter. The format is settings:set_message \"Your Message\". You can use the macro #NAME to replace with the name of the user.\n"
            exit
        end

        Setting.set("message",message)
        exit
    end
end
