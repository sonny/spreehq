namespace :radiant do
  namespace :extensions do
    namespace :lightbox do
      
      desc "Runs the migration of the Lightbox extension"
      task :migrate => :environment do
        require 'radiant/extension_migrator'
        if ENV["VERSION"]
          LightboxExtension.migrator.migrate(ENV["VERSION"].to_i)
        else
          LightboxExtension.migrator.migrate
        end
      end
      
      desc "Copies public assets of the Lightbox to the instance public/ directory."
      task :update => :environment do
        is_svn_or_dir = proc {|path| path =~ /\.svn/ || File.directory?(path) }
        Dir[LightboxExtension.root + "/public/**/*"].reject(&is_svn_or_dir).each do |file|
          path = file.sub(LightboxExtension.root, '')
          directory = File.dirname(path)
          puts "Copying #{path}..."
          mkdir_p RAILS_ROOT + directory
          cp file, RAILS_ROOT + path
        end
      end  
    end
  end
end
