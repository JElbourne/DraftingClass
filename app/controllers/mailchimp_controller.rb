require 'digest/md5'

class MailchimpController < ApplicationController
    def newsletter
        begin
            list_id = Rails.application.credentials.MAILCHIMP_LIST_ID
            gibbon = Gibbon::Request.new
            hashed_email = Digest::MD5.hexdigest(params[:email].downcase)
            gibbon.lists(list_id).members(hashed_email).upsert(body: {email_address: params[:email], status: "subscribed", merge_fields: {FNAME: params[:fname], LNAME: params[:lname]}})
            render :template => "mailchimp/newsletter"
        rescue Gibbon::MailChimpError => e
            #message = e.raw_body.to_j
            flash[:alert] = "Houston, we have a problem: #{e.detail}"
            redirect_to root_path
        end
    end

    private

        def course_params
            params.require(:mailchimp).permit(:fname, :lname, :email)
        end
end