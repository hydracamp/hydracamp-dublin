require 'jettywrapper'

namespace :hydracamp_dublin do

  desc "Test Travis CI build"
  task :test do
    ENV["RAILS_ENV"] ||= 'test'
    workspace_dir = ENV['WORKSPACE'] # workspace should be set by Hudson
    project_dir = workspace_dir ? workspace_dir : ENV['PWD']
    Rake::Task["hydra:jetty:config"].invoke
    jetty_params = {
      :jetty_home => "#{project_dir}/jetty",
      :quiet => false,
      :jetty_port => 8983,
      :solr_home => "#{project_dir}/jetty/solr",
      :fedora_home => "#{project_dir}/jetty/fedora/default",
      :startup_wait => 50
    }
    jetty_params = Jettywrapper.load_config.merge(jetty_params)

    Rake::Task["db:migrate"].invoke   
    
    error = Jettywrapper.wrap(jetty_params) do
      #puts "Refreshing fixtures in test fedora/solr"
      Rake::Task["spec"].invoke
        
    end
    raise "test failures: #{error}" if error
  end

end