
#Needed to run S3 in European buckets

#Paperclip.interpolates(:s3_eu_url) do |att, style|
#    "#{att.s3_protocol}://s3-eu-west-1.amazonaws.com/#{att.bucket}/#{att.path(style)}"
#end


#module AWS
#    module S3
#        DEFAULT_HOST = "s3-eu-west-1.amazonaws.com"
#    end
#end