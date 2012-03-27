
#Needed to run S3 in European buckets

Paperclip.interpolates(:s3_eu_url) { |attachment, style|
  "#{attachment.s3_protocol}://s3-eu-west-1.amazonaws.com/#{attachment.bucket_name}/#{attachment.path(style).gsub(%r{^/}, "")}"
}

module AWS
    module S3
        DEFAULT_HOST = "s3-eu-west-1.amazonaws.com"
    end
end