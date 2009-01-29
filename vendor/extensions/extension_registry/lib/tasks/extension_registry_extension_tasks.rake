namespace :radiant do
  namespace :extensions do
    namespace :extension_registry do
      
      desc "Runs the migration of the Extension Registry extension"
      task :migrate => :environment do
        require 'radiant/extension_migrator'
        if ENV["VERSION"]
          ExtensionRegistryExtension.migrator.migrate(ENV["VERSION"].to_i)
        else
          ExtensionRegistryExtension.migrator.migrate
        end
      end
      
      desc "Copies public assets of the Extension Registry to the instance public/ directory."
      task :update => :environment do
        is_svn_or_dir = proc {|path| path =~ /\.svn/ || File.directory?(path) }
        Dir[ExtensionRegistryExtension.root + "/public/**/*"].reject(&is_svn_or_dir).each do |file|
          path = file.sub(ExtensionRegistryExtension.root, '')
          directory = File.dirname(path)
          puts "Copying #{path}..."
          mkdir_p RAILS_ROOT + directory
          cp file, RAILS_ROOT + path
        end
      end  
    end
  end
end
