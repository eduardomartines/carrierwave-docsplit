require "carrierwave"
require "carrierwave/pdf2thumbs/version"
require "carrierwave/pdf2thumbs/processor"
require "carrierwave/pdf2thumbs/processor_service"
require "carrierwave/pdf2thumbs/collector"

module CarrierWave
  module Pdf2thumbs
    extend ActiveSupport::Concern

    module ClassMethods
      def pdf2thumbs(width, height)
        process pdf2thumbs: [width, height]
      end
    end

    def pdf2thumbs(width, height)
      self.class.instance_eval do
        before :store,  :before_store
        after  :store,  :after_store
        before :remove, :before_remove
        after  :remove, :after_remove
      end

      def before_store(new_file)
        @cache_id_was = cache_id
      end

      def before_remove
        @dir_path = store_dir
      end

      if CarrierWave::Uploader::Base.storage == CarrierWave::Storage::Fog
        def after_store(new_file)
          storage     = Fog::Storage.new(fog_credentials)
          bucket_name = CarrierWave::Uploader::Base.fog_directory
          bucket      = storage.directories.new(
            key: bucket_name
          )
          Dir.glob(File.join(root, cache_dir, @cache_id_was, "*x*", "*.png")).each do |img|
            file = bucket.files.create(
              body: File.open(img),
              key:  File.join(store_dir, img.split('/').from(-2))
            )
          end
        end

        def after_remove
          storage     = Fog::Storage.new(fog_credentials)
          bucket_name = CarrierWave::Uploader::Base.fog_directory
          storage.directories.get(bucket_name, prefix: @dir_path).files.map do |file|
            file.destroy
          end
        end
      else
        def after_store(new_file)
          if @cache_id_was.present?
            Dir.glob(File.join(root, cache_dir, @cache_id_was, "*x*")).each do |dir|
              to = File.join(root, store_dir)
              FileUtils.mv(dir, to)
            end
            FileUtils.rm_rf(File.join(root, cache_dir, @cache_id_was))
          end
        end

        def after_remove
          Dir.glob(File.join(root, @dir_path, "*x*")).each do |thumbs_folder|
            FileUtils.rm_rf(thumbs_folder)
          end
        end
      end

      CarrierWave::Pdf2thumbs::Processor.new(current_path, width, height).process
    end

    def thumbs
      if CarrierWave::Uploader::Base.storage == CarrierWave::Storage::Fog
        storage     = Fog::Storage.new(fog_credentials)
        bucket_name = CarrierWave::Uploader::Base.fog_directory
        asset_host  = CarrierWave::Uploader::Base.asset_host || ""
        path        = File.join(current_path.split("/")[0..-2])
        images      = {}

        storage.directories.get(bucket_name, prefix: path).files.map do |file|
          key = file.key.split("/")[-2]
          if key.match(/\D*x\D*/)
            images[key] ||= []
            images[key] << File.join(asset_host, file.key)
          end
        end

        return images
      else
        CarrierWave::Pdf2thumbs::Collector.new(current_path).thumbs
      end
    end
  end
end
