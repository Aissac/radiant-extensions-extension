namespace :radiant do
  namespace :extensions do
    namespace :radiant_extensions do
      
      desc "Runs the migration of the Radiant Extensions extension"
      task :migrate => :environment do
        require 'radiant/extension_migrator'
        if ENV["VERSION"]
          RadiantExtensionsExtension.migrator.migrate(ENV["VERSION"].to_i)
        else
          RadiantExtensionsExtension.migrator.migrate
        end
      end
      
      desc "Copies public assets of the Radiant Extensions to the instance public/ directory."
      task :update => :environment do
        is_svn_or_dir = proc {|path| path =~ /\.svn/ || File.directory?(path) }
        Dir[RadiantExtensionsExtension.root + "/public/**/*"].reject(&is_svn_or_dir).each do |file|
          path = file.sub(RadiantExtensionsExtension.root, '')
          directory = File.dirname(path)
          puts "Copying #{path}..."
          mkdir_p RAILS_ROOT + directory
          cp file, RAILS_ROOT + path
        end
      end  
    end
  end
end
