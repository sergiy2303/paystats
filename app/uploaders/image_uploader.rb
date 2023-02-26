# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base
  # include Cloudinary::CarrierWave

  # version :large do
  #   process :resize_to_fill => [480, 600, :north]
  # end

  # version :thumbnail do
  #   process :resize_to_fill => [150, 200, :north]
  # end

  # def extension_white_list
  #   %w(png jpg jpeg)
  # end

  # def store_dir
  #   "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  # end
end
