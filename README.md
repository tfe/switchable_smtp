[`switchable_smtp`](http://github.com/tfe/switchable_smtp/)
========

You shouldn't have to re-deploy your application in order to switch SMTP servers, which you may want to do if your provider goes down or starts acting funny, or if you start bumping up against usage limits. This plugin allows you to switch your SMTP settings on the fly. You can even specify them on a per-mail basis if you need that kind of control.


Installation
------------

    script/plugin install git://github.com/tfe/switchable_smtp.git


Usage
-----

The plugin adds a `custom_smtp` instance variable and method to `ActionMailer::Base` (to support the old and new way of configuring ActionMailer). To specify different SMTP settings for a mailing, just call this when setting up the mail:

    class ApplicationMailer < ActionMailer::Base
      def message(message)
        @recipients = "someone@example.com"
        @subject    = "Test"
        @from       = "noreply@example.com"
    
        @body[:message] = message
    
        @custom_smtp = {
          :address => "smtp.sendgrid.net",
          :user_name => "noreply@example.com",
          :password => "secret",
          :domain=>"example.com",
          :port => "25",
          :authentication => :plain
        }
      end
    end

Of course, you'll probably be fetching your custom SMTP settings hash out of the database or something, otherwise there's not much point in using this plugin. On my apps, I'm using the [`rails-settings`](http://github.com/Squeegy/rails-settings) gem to keep my settings in the database, then I just do

    @custom_smtp = Settings.active_smtp

swapping the active SMTP settings back and forth as necessary.


Credit
------

This is pretty much straight out of 
[this blog post](http://blog.flvorful.com/articles/2009/12/20/deep-in-rails-actionmailer-deliver-part-vi) 
by Jake Varghese. I've just pluginized it and provided some guidelines for using it within your app.


Contact
-------

Problems, comments, and pull requests all welcome. [Find me on GitHub.](http://github.com/tfe/)


License
-------

**The MIT License**

Copyright © 2010 [Todd Eichel](http://toddeichel.com/) for [Fooala, Inc.](http://opensource.fooala.com/).

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the 'Software'), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
