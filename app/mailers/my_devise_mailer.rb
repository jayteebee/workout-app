# class MyDeviseMailer < Devise::Mailer
#     default from: 'jethro@jethroblock.com'

#     def confirmation_instructions(record, token, opts={})
#         @token = token
#         @confirmation_url = Devise::Engine.routes.url_helpers.confirmation_url(record, confirmation_token: @token)
#         body = "Hello, please confirm your account by clicking the following link: 
#                                         #{@confirmation_url}
                                        
#                         Once you have confirmed your account, you will see an empty white screen. Simply close the tab, navigate back to the log in screen and you will be able to log in."
#         mail(to: record.email, subject: 'Confirmation instructions', body: body)
#     end
# end

# class MyDeviseMailer < Devise::Mailer
#     default from: 'jethro@jethroblock.com'

#     def confirmation_instructions(record, token, opts={})
#     @token = token
#     @confirmation_url = user_confirmation_url(record, confirmation_token: @token)
#     body = "Hello, please confirm your account by clicking the following link: 
#                                     #{@confirmation_url}
                                    
#                     Once you have confirmed your account, you will see an empty white screen. Simply close the tab, navigate back to the log in screen and you will be able to log in."
#     mail(to: record.email, subject: 'Confirmation instructions', body: body)
# end
# end
  

class MyDeviseMailer < Devise::Mailer
    default from: 'jethro@jethroblock.com'
  
    def confirmation_instructions(record, token, opts={})
      @token = token
      # Manually construct the URL
      base_url = "https://workout-app-fe-five.vercel.app/GettingStarted/confirmation"
      @confirmation_url = "#{base_url}?confirmation_token=#{@token}"
  
      body = "Hello, please confirm your account by clicking the following link: 
                                      #{@confirmation_url}
                                      
              Once you have confirmed your account, you will see an empty white screen. Simply close the tab, navigate back to the log in screen and you will be able to log in."
      mail(to: record.email, subject: 'Confirmation instructions', body: body)
    end
  end
  