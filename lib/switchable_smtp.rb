module SwitchableSmtp
  module InstanceMethods
    def deliver_with_switchable_smtp!(mail = @mail)
      unless logger.nil?
        logger.info  "Switching SMTP server to: #{custom_smtp.inspect}" 
      end
      ActionMailer::Base.smtp_settings = custom_smtp unless custom_smtp.nil?
      deliver_without_switchable_smtp!(mail = @mail)
    end
  end
  def self.included(receiver)
    receiver.send :include, InstanceMethods
    receiver.class_eval do
      adv_attr_accessor :custom_smtp
      alias_method_chain :deliver!, :switchable_smtp
    end
  end
end
